import 'package:dart_geohash/dart_geohash.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

class Coordinate extends Equatable {
  Coordinate({
    required this.latitude,
    required this.longtitude,
    String? geohash,
  }) : geohash = geohash ?? GetIt.I<GeoHasher>().encode(longtitude, latitude);

  final double latitude;
  final double longtitude;
  final String geohash;

  @override
  List<Object?> get props => [latitude, longtitude, geohash];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longtitude': longtitude,
      'geohash': geohash,
    };
  }

  factory Coordinate.fromMap(Map<String, dynamic> map) {
    return Coordinate(
      latitude: map['latitude'],
      longtitude: map['longtitude'],
      geohash: map['geohash'],
    );
  }

  Coordinate copyWith({
    double? latitude,
    double? longtitude,
    String? geohash,
  }) {
    return Coordinate(
      latitude: latitude ?? this.latitude,
      longtitude: longtitude ?? this.longtitude,
      geohash: geohash ?? this.geohash,
    );
  }
}
