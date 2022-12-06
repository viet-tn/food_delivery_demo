import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';

part 'food_state.dart';

class FoodCubit extends FCubit<FoodState> {
  FoodCubit({
    required FoodRepository foodRepository,
  })  : _foodRepository = foodRepository,
        super(const FoodState());

  final FoodRepository _foodRepository;

  void init(FFood food) async {
    emitValue(
      state.copyWith(
        food: food,
      ),
    );
  }

  Future<FFood?> fetchFoodById() async {
    emitLoading();
    final result = await _foodRepository.fetchFoodById(state.food!.id);

    if (result.isError) {
      emitError(result.error!);
      return null;
    }

    emitValue(state.copyWith(food: result.data!));
    return result.data!;
  }
}
