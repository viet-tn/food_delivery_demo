import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  const Coordinate({
    required this.latitude,
    required this.longitude,
    this.address,
    this.geohash,
  });

  final double latitude;
  final double longitude;
  final String? address;
  final String? geohash;

  @override
  List<Object?> get props => [latitude, longitude, address, geohash];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'position': {
        'geopoint': GeoPoint(latitude, longitude),
      },
    };
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    final position = map['position'];
    return Coordinate(
      latitude: position['geopoint'].latitude,
      longitude: position['geopoint'].longitude,
      address: map['address'],
      geohash: map['geohash'],
    );
  }

  factory Coordinate.fromGeoPoint(GeoPoint geoPoint) {
    return Coordinate(
        latitude: geoPoint.latitude, longitude: geoPoint.longitude);
  }

  Coordinate copyWith({
    double? latitude,
    double? longitude,
    String? geohash,
    String? address,
  }) {
    return Coordinate(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}
