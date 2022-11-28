import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../cubit/app_cubit.dart';

part 'food_state.dart';

class FoodCubit extends FCubit<FoodState> {
  FoodCubit({
    required AppCubit appCubit,
    required FoodRepository foodRepository,
  })  : _appCubit = appCubit,
        _foodRepository = foodRepository,
        super(const FoodState());

  final AppCubit _appCubit;
  final FoodRepository _foodRepository;

  void init(FFood food) async {
    emitValue(
      state.copyWith(
        food: food,
        isAddedToCart: _appCubit.state.cart!.items.containsKey(food.id),
        isAddToFavoriteList:
            _appCubit.state.favoriteList!.foodIds.contains(food.id),
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

  Future<void> addToCart() async {
    emitLoading();

    final isAddedToCart = await _appCubit.addToCart(state.food!);

    emitValue(state.copyWith(isAddedToCart: isAddedToCart));
  }

  void toggleFavoriteList(bool isDelete) async {
    emitValue(state.copyWith(isAddToFavoriteList: !isDelete));
    final success = isDelete
        ? await _appCubit.removeFromFavoriteList(state.food!.id)
        : await _appCubit.addToFavoriteList(state.food!);

    emitValue(
      state.copyWith(isAddToFavoriteList: success ? !isDelete : null),
    );
  }
}
