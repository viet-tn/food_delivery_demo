// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FFavoriteList {
  const FFavoriteList(this.id, [this.foodIds = const <String>[]]);

  final String id;
  final List<String> foodIds;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foodId': foodIds,
    };
  }

  factory FFavoriteList.fromMap(Map<String, dynamic> map) {
    return FFavoriteList(
      map['id'],
      List<String>.from(map['foodId']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FFavoriteList.fromJson(String source) =>
      FFavoriteList.fromMap(json.decode(source) as Map<String, dynamic>);

  FFavoriteList copyWith({
    String? id,
    List<String>? foodId,
  }) {
    return FFavoriteList(
      id ?? this.id,
      foodId ?? foodIds,
    );
  }
}
