import 'package:equatable/equatable.dart';

class FPlace extends Equatable {
  const FPlace({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.distance,
    this.duration,
  });

  final String name;
  final String address;

  /// meter
  final int? distance;

  /// second
  final int? duration;
  final double latitude;
  final double longitude;

  @override
  List<Object?> get props => [
        name,
        address,
        distance,
        latitude,
        longitude,
        duration,
      ];

  FPlace copyWith({
    String? name,
    String? address,
    double? latitude,
    double? longtitude,
    int? distance,
    int? duration,
  }) {
    return FPlace(
      name: name ?? this.name,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      latitude: latitude ?? this.latitude,
      longitude: longtitude ?? longitude,
      duration: duration ?? this.duration,
    );
  }
}
