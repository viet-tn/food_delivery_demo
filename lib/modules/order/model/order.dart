import 'package:equatable/equatable.dart';
import '../../../repositories/users/coordinate.dart';

import '../../../repositories/cart/cart_model.dart';

enum OrderStatus { processing, delivered, cancelled }

class FOrder extends Equatable {
  const FOrder({
    this.id,
    this.status = OrderStatus.processing,
    required this.address,
    required this.cart,
    required this.created,
    required this.discount,
    required this.deliveryCharge,
    required this.subTotal,
  });

  final String? id;
  final OrderStatus status;
  final Coordinate address;
  final FCart cart;
  final DateTime created;
  final double discount;
  final double deliveryCharge;
  final double subTotal;

  double get paid => subTotal + deliveryCharge - discount;

  @override
  List<Object?> get props => [
        id,
        status,
        address,
        cart,
        created,
        discount,
        deliveryCharge,
        subTotal,
      ];

  FOrder copyWith({
    String? id,
    OrderStatus? status,
    Coordinate? address,
    FCart? cart,
    DateTime? created,
    double? discount,
    double? deliveryCharge,
    double? subTotal,
  }) {
    return FOrder(
      id: id ?? this.id,
      status: status ?? this.status,
      address: address ?? this.address,
      cart: cart ?? this.cart,
      created: created ?? this.created,
      discount: discount ?? this.discount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      subTotal: subTotal ?? this.subTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status.name,
      'address': address.toMap(),
      'cart': cart.toMap(),
      'created': created,
      'discount': discount,
      'deliveryCharge': deliveryCharge,
      'subTotal': subTotal,
    };
  }

  factory FOrder.fromMap(Map<String, dynamic> map) {
    return FOrder(
      id: map['id'],
      status: OrderStatus.values.byName(map['status']),
      address: Coordinate.fromMap(map['address']),
      cart: FCart.fromMap(map['cart']),
      created: map['created'].toDate(),
      discount: map['discount'],
      deliveryCharge: map['deliveryCharge'],
      subTotal: map['subTotal'],
    );
  }
}
