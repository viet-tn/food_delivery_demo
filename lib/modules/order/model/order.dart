import 'package:equatable/equatable.dart';

import '../../../repositories/cart/cart_model.dart';
import '../../../repositories/users/coordinate.dart';

enum OrderStatus { processing, delivered, cancelled }

class FOrder extends Equatable {
  const FOrder({
    this.id,
    this.status = OrderStatus.processing,
    required this.name,
    required this.phone,
    required this.userPosition,
    required this.cart,
    required this.created,
    required this.discount,
    required this.deliveryCharge,
    required this.subTotal,
  });

  final String? id;
  final OrderStatus status;
  final String name;
  final String phone;
  final Coordinate userPosition;
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
        userPosition,
        cart,
        created,
        discount,
        deliveryCharge,
        subTotal,
      ];

  FOrder copyWith({
    String? id,
    OrderStatus? status,
    String? name,
    String? phone,
    Coordinate? userPosition,
    FCart? cart,
    DateTime? created,
    double? discount,
    double? deliveryCharge,
    double? subTotal,
  }) {
    return FOrder(
      id: id ?? this.id,
      status: status ?? this.status,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      userPosition: userPosition ?? this.userPosition,
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
      'name': name,
      'phone': phone,
      'userPosition': userPosition.toMap(),
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
      name: map['name'],
      phone: map['phone'],
      userPosition: Coordinate.fromMap(map['userPosition']),
      cart: FCart.fromMap(map['cart']),
      created: map['created'].toDate(),
      discount: map['discount'],
      deliveryCharge: map['deliveryCharge'],
      subTotal: map['subTotal'],
    );
  }
}
