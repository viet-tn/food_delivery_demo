import 'dart:convert';

import 'package:equatable/equatable.dart';

class FFood extends Equatable {
  const FFood({
    required this.id,
    required this.img,
    required this.name,
    required this.description,
    required this.price,
    required this.rate,
    required this.country,
    required this.category,
    required this.restaurantId,
  });

  final String id;
  final String img;
  final String name;
  final String description;
  final double price;
  final int rate;
  final String country;
  final String category;
  final String restaurantId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'img': img,
      'name': name,
      'dsc': description,
      'price': price,
      'rate': rate,
      'country': country,
      'category': category,
      'restaurantId': restaurantId,
    };
  }

  factory FFood.fromMap(Map<String, dynamic> map) {
    return FFood(
      id: map['id'],
      img: map['img'],
      name: map['name'],
      description: map['dsc'],
      price: (map['price'] as num).toDouble(),
      rate: (map['rate'] as num).toInt(),
      country: map['country'],
      category: map['category'],
      restaurantId: map['restaurantId'],
    );
  }

  FFood copyWith({
    String? id,
    String? img,
    String? name,
    String? description,
    double? price,
    int? rate,
    String? country,
    String? category,
    String? restaurantId,
  }) {
    return FFood(
      id: id ?? this.id,
      img: img ?? this.img,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      rate: rate ?? this.rate,
      country: country ?? this.country,
      category: category ?? this.category,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      img,
      name,
      description,
      price,
      rate,
      country,
      category,
      restaurantId,
    ];
  }

  String toJson() => json.encode(toMap());

  factory FFood.fromJson(String source) =>
      FFood.fromMap(json.decode(source) as Map<String, dynamic>);
}
