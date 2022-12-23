part of 'cart_cubit.dart';

class CartState extends FState {
  const CartState({
    super.status,
    super.errorMessage,
    this.cart = const FCart(),
    this.foods = const <FFood>[],
    this.deliveryCharge = 0,
    this.discount = 0,
  });

  final FCart cart;
  final List<FFood> foods;
  final int deliveryCharge;
  final int discount;

  int get subTotal => foods.fold(
        0,
        (previousValue, element) =>
            previousValue +
            element.price.toInt() * (cart.items[element.id] ?? 0),
      );
  int get total => max(subTotal - discount + deliveryCharge, 0);

  @override
  List<Object?> get props => [
        ...super.props,
        cart,
        foods,
        deliveryCharge,
        discount,
      ];

  @override
  CartState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FCart? cart,
    List<FFood>? foods,
    int? deliveryCharge,
    int? discount,
  }) {
    return CartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cart: cart ?? this.cart,
      foods: foods ?? this.foods,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      discount: discount ?? this.discount,
    );
  }
}
