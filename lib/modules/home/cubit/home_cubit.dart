import '../../../repositories/maps/search/places_search_repository.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../repositories/restaurants/restaurant_repository.dart';

part 'home_state.dart';

class HomeCubit extends FCubit<HomeState> {
  HomeCubit({
    required RestaurantRepository restaurantRepository,
    required FoodRepository foodRepository,
    required PlacesSearchRepository placesSearchRepository,
  })  : _restaurantRepository = restaurantRepository,
        _foodRepository = foodRepository,
        _placesSearchRepository = placesSearchRepository,
        super(const HomeState());

  final RestaurantRepository _restaurantRepository;
  final FoodRepository _foodRepository;
  final PlacesSearchRepository _placesSearchRepository;

  void init(double latitudeSrc, double longitudeSrc) async {
    await Future.wait([
      fetchFistPopularFoodBatch(),
      fetchNearestRestaurant(latitudeSrc, longitudeSrc),
    ]);

    final update = <FRestaurant>[];
    await Future.forEach(state.restaurants, (restaurant) async {
      final distance = await _placesSearchRepository.calculateDistance(
          restaurant.coordinate.latitude,
          restaurant.coordinate.longitude,
          latitudeSrc,
          longitudeSrc);
      update.add(restaurant.copyWith(duration: distance[1]));
    });

    emitValue(
      state.copyWith(
        restaurants: update,
      ),
    );
  }

  Future<void> fetchNearestRestaurant(
      double latitudeSrc, double longitudeSrc) async {
    final result = await _restaurantRepository.fetchNearestRestaurants(
        latitudeSrc, longitudeSrc);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emit(state.copyWith(restaurants: result.data!));
  }

  Future<void> fetchFistPopularFoodBatch() async {
    final result = await _foodRepository.fetchFoods(null, 5);
    if (result.isError) {
      return emitError(result.error!);
    }
    return emit(state.copyWith(
      foods: [...state.foods, ...result.data!],
    ));
  }
}
