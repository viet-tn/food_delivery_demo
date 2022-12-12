import 'package:equatable/equatable.dart';

import '../users/coordinate.dart';

class FRestaurant extends Equatable {
  const FRestaurant({
    required this.id,
    required this.name,
    required this.url,
    this.foodIds = const <String>[],
    required this.coordinate,
    this.duration,
  });

  final String id;
  final String name;
  final String url;
  final Coordinate coordinate;

  /// List of food id
  final List<String> foodIds;
  final int? duration;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'menu': foodIds.map((id) => {'food_id': id}).toList(),
      'coordinate': coordinate.toMap(),
    };
  }

  factory FRestaurant.fromMap(Map<String, dynamic> map) {
    return FRestaurant(
      id: map['id'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
      foodIds:
          (map['menu'] as List).map((e) => e['food_id']! as String).toList(),
      coordinate: Coordinate.fromMap(map['coordinate']),
    );
  }

  FRestaurant copyWith({
    String? id,
    String? name,
    String? url,
    List<String>? menu,
    Coordinate? coordinate,
    int? duration,
  }) {
    return FRestaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      foodIds: menu ?? foodIds,
      coordinate: coordinate ?? this.coordinate,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [id, name, url, foodIds, coordinate, duration];
}
