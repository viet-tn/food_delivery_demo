import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../repositories/restaurants/restaurant_repository.dart';
import '../../../base/cubit.dart';
import '../../../base/state.dart';

part 'home_state.dart';

class HomeCubit extends FCubit<HomeState> {
  HomeCubit({
    required RestaurantRepository restaurantRepository,
    required FoodRepository foodRepository,
  })  : _restaurantRepository = restaurantRepository,
        _foodRepository = foodRepository,
        super(const HomeState());

  void init() async {
    await fetchFistFoodBatch();
    await fetchNearestRestaurant();
    emitValue();
  }

  final RestaurantRepository _restaurantRepository;
  final FoodRepository _foodRepository;

  Future<void> fetchNearestRestaurant() async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await _restaurantRepository.fetchNearestRestaurant();

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emit(state.copyWith(restaurants: result.data!));
  }

  Future<void> fetchFistFoodBatch() async {
    final result = await _foodRepository.fetchFoods(null, 5);
    if (result.isError) {
      return emitError(result.error!);
    }
    return emit(state.copyWith(
      foods: [...state.foods, ...result.data!],
    ));
  }

  Future<void> fetchNextFoodBatch() async {
    final result = await _foodRepository.fetchFoods(state.foods.last);
    if (result.isError) {
      return emitError(result.error!);
    }
    return emitValue(state.copyWith(
      foods: [...state.foods, ...result.data!],
    ));
  }
}
