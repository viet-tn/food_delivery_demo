import '../../../../base/cubit.dart';
import '../../../../base/state.dart';
import '../../../../repositories/food/food_model.dart';
import '../../../../repositories/food/food_repository.dart';
import '../../../../repositories/restaurants/restaurant_model.dart';
import '../../../../repositories/restaurants/restaurant_repository.dart';

part 'view_more_state.dart';

class ViewMoreCubit extends FCubit<ViewMoreState> {
  ViewMoreCubit(
    this._foodRepository,
    this._restaurantRepository,
  ) : super(const ViewMoreState());

  final FoodRepository _foodRepository;
  final RestaurantRepository _restaurantRepository;

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
    final result =
        await _restaurantRepository.fetchNearestRestaurants(null, 10);
    if (result.isError) {
      return emitError(result.error!);
    }
    return emitValue(state.copyWith(
      restaurants: [...result.data!],
    ));
  }

  void fetchNextNearestRestaurantBatch() async {
    emitLoading();
    final result = await _restaurantRepository
        .fetchNearestRestaurants(state.restaurants!.last);
    if (result.isError) {
      return emitError(result.error!);
    }
    return emitValue(state.copyWith(
      restaurants: [...state.restaurants!, ...result.data!],
    ));
  }
}
