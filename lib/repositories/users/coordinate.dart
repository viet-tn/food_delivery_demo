import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Coordinate extends Equatable {
  const Coordinate({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  final double latitude;
  final double longitude;
  final String? address;

  @override
  List<Object?> get props => [latitude, longitude, address];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'address': address
    };
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
      latitude: map['latitude'],
      longitude: map['longitude'],
      address: map['address'],
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
