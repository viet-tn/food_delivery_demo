import 'package:equatable/equatable.dart';

class FRestaurant extends Equatable {
  const FRestaurant({
    required this.id,
    required this.name,
    required this.url,
    this.foodIds = const <String>[],
  });

  final String id;
  final String name;
  final String url;

  /// List of food id
  final List<String> foodIds;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'menu': foodIds.map((id) => {'food_id': id}).toList(),
    };
  }

  factory FRestaurant.fromMap(Map<String, dynamic> map) {
    return FRestaurant(
      id: map['id'] as String,
      name: map['name'] as String,
      url: map['url'] as String,
      foodIds:
          (map['menu'] as List).map((e) => e['food_id']! as String).toList(),
    );
  }

  FRestaurant copyWith({
    String? id,
    String? name,
    String? url,
    List<String>? menu,
  }) {
    return FRestaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      foodIds: menu ?? foodIds,
    );
  }

  @override
  List<Object> get props => [id, name, url, foodIds];
}
