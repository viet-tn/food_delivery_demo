import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/cart/cart_model.dart';
import '../../../repositories/cart/item_model.dart';
import '../../../repositories/food/food_model.dart';
import '../../cubit/app_cubit.dart';

part 'cart_state.dart';

class CartCubit extends FCubit<CartState> {
  CartCubit({
    required AppCubit appCubit,
  })  : _appCubit = appCubit,
        super(const CartState()) {
    init();
  }

  final AppCubit _appCubit;

  void init() async {
    final cart = _appCubit.state.cart!;
    final foodList = _appCubit.state.cartFoodList;

    final subTotal = foodList.fold(
      0,
      (previousValue, element) =>
          previousValue + element.price.toInt() * (cart.items[element.id] ?? 0),
    );

    return emitValue(state.copyWith(
      cart: cart,
      foods: foodList,
      subTotal: subTotal,
    ));
  }

  Future<void> onQuantityChanged(Item item) async {
    emitLoading();
    final update = await _appCubit.onCartQuantityChanged(item);

    emitValue(
      state.copyWith(
        cart: update,
        subTotal: _subTotalCalculator(update, state.foods),
      ),
    );
  }

  Future<void> onDeleteItem(String foodId) async {
    emitLoading();
    final updateCart = await _appCubit.onCartItemDeleted(foodId);
    final updateFoods = [
      for (var food in state.foods)
        if (food.id != foodId) food
    ];

    emitValue(
      state.copyWith(
        cart: updateCart,
        foods: updateFoods,
        subTotal: _subTotalCalculator(updateCart, updateFoods),
      ),
    );
  }

  int _subTotalCalculator(FCart cart, List<FFood> foodList) {
    return foodList.fold(
      0,
      (previousValue, element) =>
          previousValue + element.price.toInt() * (cart.items[element.id] ?? 0),
    );
  }
}
