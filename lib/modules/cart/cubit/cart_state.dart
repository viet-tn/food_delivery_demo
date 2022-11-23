part of 'cart_cubit.dart';

class CartState extends FState {
  const CartState({
    super.status,
    super.errorMessage,
    this.cart = const FCart(),
    this.foods = const <FFood>[],
    this.subTotal = 0,
    this.deliveryCharge = 0,
    this.discount = 0,
  });

  final FCart cart;
  final List<FFood> foods;
  final int subTotal;
  final int deliveryCharge;
  final int discount;

  @override
  List<Object?> get props => [
        ...super.props,
        cart,
        foods,
        subTotal,
        deliveryCharge,
        discount,
      ];

  @override
  CartState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FCart? cart,
    List<FFood>? foods,
    int? subTotal,
    int? deliveryCharge,
    int? discount,
  }) {
    return CartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      cart: cart ?? this.cart,
      foods: foods ?? this.foods,
      subTotal: subTotal ?? this.subTotal,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      discount: discount ?? this.discount,
    );
  }
}
