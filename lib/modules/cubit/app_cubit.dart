import '../signup/cubit/sign_up_cubit.dart';
import '../../repositories/auth/auth_repository.dart';
import '../../repositories/cloud_storage/cloud_storage.dart';
import '../../repositories/users/user_repository.dart';
import 'package:get_it/get_it.dart';

import '../../../repositories/cart/mutable_cart.dart';
import '../../base/cubit.dart';
import '../../base/state.dart';
import '../../repositories/cart/cart_model.dart';
import '../../repositories/cart/cart_repository.dart';
import '../../repositories/cart/item_model.dart';
import '../../repositories/favorite/favorite_list_model.dart';
import '../../repositories/favorite/favorite_list_repository.dart';
import '../../repositories/food/food_model.dart';
import '../../repositories/food/food_repository.dart';
import '../../repositories/users/user_model.dart';
import '../login/cubit/login_cubit.dart';

part 'app_state.dart';

class AppCubit extends FCubit<AppState> {
  AppCubit({
    required FavoriteListRepository favoriteListRepository,
    required CartRepository cartRepository,
    required FoodRepository foodRepository,
    required CloudStorage cloudStorage,
    required UserRepository userRepository,
    required AuthRepository authRepository,
  })  : _favoriteListRepository = favoriteListRepository,
        _cartRepository = cartRepository,
        _foodRepository = foodRepository,
        _cloudStorage = cloudStorage,
        _userRepository = userRepository,
        _authRepository = authRepository,
        super(const AppState());

  final FavoriteListRepository _favoriteListRepository;
  final CartRepository _cartRepository;
  final FoodRepository _foodRepository;
  final CloudStorage _cloudStorage;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

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
    await _authRepository.signOut();
    emit(const AppState());
    GetIt.I<SignUpCubit>().emit(const SignUpState());
    GetIt.I<LoginCubit>().emit(
      GetIt.I<LoginCubit>().state.copyWith(user: FUser.empty),
    );
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

  void updateUserState(FUser user) {
    emitValue(state.copyWith(user: user));
  }

  Future<void> updateUserToDatabase([String? imgUrl]) async {
    emitLoading();
    FUser? update;

    if (imgUrl != null) {
      update = state.user!.copyWith(
        photo: await _cloudStorage.uploadAvatar(state.user!.id, imgUrl),
      );
    }
    final result = await _userRepository.set(update ?? state.user!);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state.copyWith(user: result.data!));
  }

  void deleteUserFromDatabase() {
    _authRepository.deleteUser().then((value) {
      if (value.isError) {
        emitError(value.error!);
        return;
      }
      signOut();
    });
    _userRepository.delete(state.user!.id);
  }

  void changePassword(String currentPassword, String newPassword) async {
    emitLoading();
    final result =
        await _authRepository.changePassword(currentPassword, newPassword);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue();
  }
}
