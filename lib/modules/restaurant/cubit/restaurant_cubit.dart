import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../repositories/result.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends FCubit<RestaurantState> {
  RestaurantCubit({required FoodRepository foodRepository})
      : _foodRepository = foodRepository,
        super(const RestaurantState());

  final FoodRepository _foodRepository;

  void init(FRestaurant restaurant) {
    emitValue(state.copyWith(restaurant: restaurant));
  }

  Future<List<FFood>> fetchFoods() async {
    emitLoading();
    final result = await _foodRepository
        .fetchFoodsByIds(state.restaurant!.foodIds.sublist(0, 10));
    return _fetchFoodsHandler(result);
  }

  Future<List<FFood>> fetchAllFoods() async {
    emitLoading();
    final result =
        await _foodRepository.fetchFoodsByIds(state.restaurant!.foodIds);
    return _fetchFoodsHandler(result);
  }

  List<FFood> _fetchFoodsHandler(FResult<List<FFood>> result) {
    if (result.isError) {
      emitError(result.error!);
      return <FFood>[];
    }
    emitValue(state.copyWith(
      foods: result.data!,
    ));
    return result.data!;
  }
}
