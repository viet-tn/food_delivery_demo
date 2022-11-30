import 'package:equatable/equatable.dart';

class FPlace extends Equatable {
  const FPlace({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longtitude,
    this.distance,
  });

  final String name;
  final String address;
  final String? distance;
  final double latitude;
  final double longtitude;

  @override
  List<Object?> get props => [name, address, distance, latitude, longtitude];

  FPlace copyWith({
    String? name,
    String? address,
    String? distance,
    double? latitude,
    double? longtitude,
  }) {
    return FPlace(
      name: name ?? this.name,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      latitude: latitude ?? this.latitude,
      longtitude: longtitude ?? this.longtitude,
    );
  }
}
