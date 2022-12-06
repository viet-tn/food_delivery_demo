import '../../../base/state.dart';
import '../../../repositories/favorite/favorite_list_model.dart';
import '../../../repositories/favorite/favorite_list_repository.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';

import '../../../base/cubit.dart';

part 'favorite_state.dart';

class FavoriteCubit extends FCubit<FavoriteState> {
  FavoriteCubit({
    required this.uid,
    required FavoriteListRepository favoriteListRepository,
    required FoodRepository foodRepository,
  })  : _favoriteListRepository = favoriteListRepository,
        _foodRepository = foodRepository,
        super(const FavoriteState());

  final String uid;
  final FavoriteListRepository _favoriteListRepository;
  final FoodRepository _foodRepository;

  void fetchFavoriteList() async {
    emitLoading();
    final result = await _favoriteListRepository.fetchFavoriteList(uid);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        favoriteList: result.data!,
      ),
    );

    fetchFoodByIds(state.favoriteList!.foodIds);
  }

  void fetchFoodByIds(List<String> foodIds) async {
    final result = await _foodRepository.fetchFoodsByIds(foodIds);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        foods: result.data!,
      ),
    );
  }

  void toggleFavoriteList(FFood food) async {
    late final FFavoriteList update;
    if (state.favoriteList?.foodIds.contains(food.id) ?? false) {
      update = state.favoriteList!.copyWith(
        foodId: state.favoriteList!.foodIds.toList()..remove(food.id),
      );
      emitValue(
        state.copyWith(
          favoriteList: update,
          foods: state.foods.toList()..remove(food),
        ),
      );
      _favoriteListRepository.setFavoriteList(update);
      return;
    }

    update = state.favoriteList!.copyWith(
      foodId: [...state.favoriteList!.foodIds, food.id],
    );
    emitValue(
      state.copyWith(
        favoriteList: update,
        foods: [...state.foods, food],
      ),
    );
    _favoriteListRepository.setFavoriteList(update);
  }
}
