import '../../../repositories/cart/mutable_cart.dart';
import '../../repositories/cart/cart_model.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/cart/item_model.dart';
import '../../repositories/domain_manager.dart';
import '../../repositories/favorite/favorite_list_model.dart';
import '../../repositories/favorite/favorite_list_repository.dart';
import '../../repositories/food/food_model.dart';
import '../../repositories/food/food_repository.dart';
import '../../repositories/users/user_model.dart';
import '../../base/cubit.dart';
import '../../base/state.dart';

part 'app_state.dart';

class AppCubit extends FCubit<AppState> {
  AppCubit({
    required FavoriteListRepository favoriteListRepository,
    required CartRepository cartRepository,
    required FoodRepository foodRepository,
  })  : _favoriteListRepository = favoriteListRepository,
        _cartRepository = cartRepository,
        _foodRepository = foodRepository,
        super(const AppState());

  final FavoriteListRepository _favoriteListRepository;
  final CartRepository _cartRepository;
  final FoodRepository _foodRepository;

  void init(FUser user) async {
    final favoriteResult =
        await _favoriteListRepository.fetchFavoriteList(user.id);

    if (favoriteResult.isError) {
      emitError(favoriteResult.error!);
      return;
    }

    final favoriteFoodResult =
        await _foodRepository.fetchFoodsByIds(favoriteResult.data!.foodIds);

    if (favoriteFoodResult.isError) {
      emitError(favoriteFoodResult.error!);
      return;
    }

    final cartResult = await _cartRepository.fetchCart();

    if (cartResult.isError) {
      emitError(cartResult.error!);
      return;
    }

    final cartFoodResult = await _foodRepository
        .fetchFoodsByIds(cartResult.data!.items.keys.toList());

    if (cartFoodResult.isError) {
      emitError(cartFoodResult.error!);
      return;
    }

    emitValue(
      state.copyWith(
        user: user,
        favoriteList: favoriteResult.data!,
        favoriteFoodList: favoriteFoodResult.data!,
        cart: cartResult.data!,
        cartFoodList: cartFoodResult.data!,
      ),
    );
  }

  Future<void> signOut() async {
    emitLoading();
    await DomainManager().authRepository.signOut();
    emit(const AppState());
  }

  /// return true if success otherwise return false
  Future<bool> addToFavoriteList(FFood food) async {
    emitLoading();
    final update = FFavoriteList(
      state.user!.id,
      state.favoriteList!.foodIds..add(food.id),
    );

    final result = await _favoriteListRepository.setFavoriteList(update);

    if (result.isError) {
      emitError(result.error!);
      return false;
    }

    emitValue(
      state.copyWith(
        favoriteList: update,
        favoriteFoodList: [...state.favoriteFoodList, food],
      ),
    );
    return true;
  }

  /// return true if success otherwise return false
  Future<bool> removeFromFavoriteList(String foodId) async {
    emitLoading();
    final update = FFavoriteList(
      state.user!.id,
      state.favoriteList!.foodIds..remove(foodId),
    );

    final result = await _favoriteListRepository.setFavoriteList(update);

    if (result.isError) {
      emitError(result.error!);
      return false;
    }

    final foodList = [
      for (var food in state.favoriteFoodList)
        if (food.id != foodId) food
    ];

    emitValue(
      state.copyWith(
        favoriteList: update,
        favoriteFoodList: foodList,
      ),
    );
    return true;
  }

  /// return true if success otherwise return false
  Future<bool> addToCart(FFood food) async {
    emitLoading();
    final update = state.cart!.addItem(
      Item(
        foodId: food.id,
        quantity: 1,
      ),
    );

    final result = await _cartRepository.setCart(update);

    if (result.isError) {
      emitError(result.error!);
      return false;
    }

    emitValue(
      state.copyWith(
        cart: update,
        cartFoodList: [...state.cartFoodList, food],
      ),
    );
    return true;
  }

  Future<FCart> onCartQuantityChanged(Item item) async {
    final update = state.cart!.setItem(item);
    final result = await _cartRepository.setCart(update);

    if (result.isError) {
      emitError(result.error!);
      return state.cart!;
    }

    emitValue(state.copyWith(cart: update));
    return update;
  }

  Future<FCart> onCartItemDeleted(String foodId) async {
    final update = state.cart!.removeItemById(foodId);
    final result = await _cartRepository.setCart(update);

    if (result.isError) {
      emitError(result.error!);
      return state.cart!;
    }

    final foodList = state.cartFoodList
      ..removeWhere((food) => food.id == foodId);

    emitValue(
      state.copyWith(
        cart: update,
        cartFoodList: foodList,
      ),
    );
    return update;
  }
}
