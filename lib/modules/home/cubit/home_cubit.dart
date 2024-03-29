import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/maps/search/places_search_repository.dart';
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

    emitValue();

    final update = <FRestaurant>[];
    await Future.wait(state.restaurants.map((restaurant) async {
      final matrix = await _placesSearchRepository.calculateDistance(
        restaurant.coordinate.latitude,
        restaurant.coordinate.longitude,
        latitudeSrc,
        longitudeSrc,
      );
      return update.add(restaurant.copyWith(
        distance: matrix[0],
        duration: matrix[1],
      ));
    }));

    emitValue(
      state.copyWith(
        restaurants: update..sort((a, b) => a.distance!.compareTo(b.distance!)),
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
