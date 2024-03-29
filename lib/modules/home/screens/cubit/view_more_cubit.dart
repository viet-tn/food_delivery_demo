import 'package:get_it/get_it.dart';

import '../../../../base/cubit.dart';
import '../../../../base/state.dart';
import '../../../../repositories/food/food_model.dart';
import '../../../../repositories/food/food_repository.dart';
import '../../../../repositories/maps/search/places_search_repository.dart';
import '../../../../repositories/restaurants/restaurant_model.dart';
import '../../../../repositories/restaurants/restaurant_repository.dart';
import '../../../../repositories/users/coordinate.dart';
import '../../../cubits/app/app_cubit.dart';

part 'view_more_state.dart';

class ViewMoreCubit extends FCubit<ViewMoreState> {
  ViewMoreCubit(
    this._foodRepository,
    this._restaurantRepository,
    this._placesSearchRepository,
  ) : super(const ViewMoreState());

  final FoodRepository _foodRepository;
  final RestaurantRepository _restaurantRepository;
  final PlacesSearchRepository _placesSearchRepository;

  void fetchFistPopularFoodBatch() async {
    emitLoading();
    final result = await _foodRepository.fetchPopularFoods();
    if (result.isError) {
      return emitError(result.error!);
    }
    return emitValue(state.copyWith(
      foods: [...result.data!],
    ));
  }

  void fetchNextPopularFoodBatch() async {
    emitLoading();
    final result = await _foodRepository.fetchPopularFoods(state.foods!.last);
    if (result.isError) {
      return emitError(result.error!);
    }
    return emitValue(state.copyWith(
      foods: [...state.foods!, ...result.data!],
    ));
  }

  void fetchFistNearestRestaurantBatch() async {
    emitLoading();
    final coord = GetIt.I<AppCubit>().state.user!.coordinates.first;
    final result = await _restaurantRepository.fetchNearestRestaurants(
        coord.latitude, coord.longitude, null, 8);
    if (result.isError) {
      return emitError(result.error!);
    }

    final update = await _updateDurationAndEmitValue(result.data!, coord);
    emit(state.copyWith(restaurants: update));
  }

  void fetchNextNearestRestaurantBatch() async {
    emitLoading();
    final coord = GetIt.I<AppCubit>().state.user!.coordinates.first;
    final result = await _restaurantRepository.fetchNearestRestaurants(
        coord.latitude, coord.longitude, state.restaurants!.last);
    if (result.isError) {
      return emitError(result.error!);
    }

    if (result.data!.isEmpty) return;

    final update = await _updateDurationAndEmitValue(result.data!, coord);
    emit(state.copyWith(restaurants: [...state.restaurants!, ...update]));
  }

  Future<List<FRestaurant>> _updateDurationAndEmitValue(
      List<FRestaurant> result, Coordinate coordinate) async {
    final update = <FRestaurant>[];
    await Future.wait(state.restaurants!.map((restaurant) async {
      final matrix = await _placesSearchRepository.calculateDistance(
        restaurant.coordinate.latitude,
        restaurant.coordinate.longitude,
        coordinate.latitude,
        coordinate.longitude,
      );
      return update.add(restaurant.copyWith(
        distance: matrix[0],
        duration: matrix[1],
      ));
    }));
    return update;
  }
}
