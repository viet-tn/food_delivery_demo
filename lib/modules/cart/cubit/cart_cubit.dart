import 'dart:math';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/cart/cart_model.dart';
import '../../../repositories/cart/cart_repository.dart';
import '../../../repositories/cart/item_model.dart';
import '../../../repositories/cart/mutable_cart.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/restaurants/restaurant_repository.dart';

part 'cart_state.dart';

class CartCubit extends FCubit<CartState> {
  CartCubit({
    required CartRepository cartRepository,
    required FoodRepository foodRepository,
    required RestaurantRepository restaurantRepository,
  })  : _cartRepository = cartRepository,
        _foodRepository = foodRepository,
        _restaurantRepository = restaurantRepository,
        super(const CartState()) {
    init();
  }

  final CartRepository _cartRepository;
  final FoodRepository _foodRepository;
  final RestaurantRepository _restaurantRepository;

  void init() async {
    final cartResult = await _cartRepository.fetchCart();

    if (cartResult.isError) {
      emitError(cartResult.error!);
      return;
    }

    final cart = cartResult.data!;

    final foodsResult =
        await _foodRepository.fetchFoodsByIds(cart.items.keys.toList());

    if (foodsResult.isError) {
      emitError(foodsResult.error!);
      return;
    }

    final foodList = foodsResult.data!;

    return emitValue(state.copyWith(
      cart: cart,
      foods: foodList,
    ));
  }

  Future<void> onQuantityChanged(Item item) async {
    final update = state.cart.setItem(item);
    final result = await _cartRepository.setCart(update);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        cart: update,
      ),
    );
  }

  Future<void> onDeleteItem(String foodId) async {
    emitLoading();
    final update = state.cart.removeItemById(foodId);
    final result = await _cartRepository.setCart(update);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    final foodList = state.foods..removeWhere((food) => food.id == foodId);

    emitValue(
      state.copyWith(
        cart: update,
        foods: foodList,
      ),
    );
  }

  void addToCart(FFood food) async {
    emitLoading();
    final restaurantResult = await _restaurantRepository.getByFoodId(food.id);

    if (restaurantResult.isError) {
      emitError(restaurantResult.error!);
      return;
    }

    final update = state.cart.addItem(
      Item(
        foodId: food.id,
        quantity: 1,
      ),
      restaurantResult.data!,
    );

    final result = await _cartRepository.setCart(update);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        cart: update,
        foods: [...state.foods, food],
      ),
    );
  }

  void onVoucherChanged(int amount) {
    emitValue(state.copyWith(discount: amount));
  }

  void clear() {
    _cartRepository.clear();
    emitValue(const CartState());
  }
}
