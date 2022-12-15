import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../base_collection_reference.dart';
import '../result.dart';
import 'restaurant_model.dart';
import 'restaurant_repository.dart';

class RestaurantRepositoryImpl extends BaseCollectionReference<FRestaurant>
    implements RestaurantRepository {
  RestaurantRepositoryImpl()
      : super(
          FirebaseFirestore.instance
              .collection("restaurants")
              .withConverter<FRestaurant>(
                fromFirestore: (snapshot, _) =>
                    FRestaurant.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (restaurant) => restaurant.id,
          setID: (restaurant, id) => restaurant.copyWith(id: id),
        );

  @override
  Future<FResult<List<FRestaurant>>> fetchNearestRestaurants(
      double latitudeSrc, double longitudeSrc,
      [FRestaurant? restaurant, int limit = 5, double radius = 25]) async {
    final center = GeoPoint(latitudeSrc, longitudeSrc);

    double latPerKm = 0.00902;
    double lonPerKm = 0.00914;

    double lowerLat = center.latitude - (latPerKm * radius);
    double lowerLon = center.longitude - (lonPerKm * radius);

    double greaterLat = center.latitude + (latPerKm * radius);
    double greaterLon = center.longitude + (lonPerKm * radius);

    GeoPoint lesserGeoPoint = GeoPoint(lowerLat, lowerLon);
    GeoPoint greaterGeoPoint = GeoPoint(greaterLat, greaterLon);

    final geopointRef = FieldPath(const ['coordinate', 'position', 'geopoint']);
    final querySnapshot = await ref
        .where(geopointRef, isGreaterThan: lesserGeoPoint)
        .where(geopointRef, isLessThan: greaterGeoPoint)
        .get();

    final result = querySnapshot.docs.map((e) => e.data()).toList()
      ..sort(
        (a, b) => _calulateRelativeDistance(
          latitudeSrc,
          a.coordinate.latitude,
          longitudeSrc,
          a.coordinate.longitude,
        ).compareTo(
          _calulateRelativeDistance(
            latitudeSrc,
            b.coordinate.latitude,
            longitudeSrc,
            b.coordinate.longitude,
          ),
        ),
      );

    if (restaurant == null) {
      return FResult.success(result.sublist(0, limit));
    }

    int index = result.indexWhere((e) => e.id == restaurant.id);
    if (index == result.length - 1) {
      return FResult.success(const <FRestaurant>[]);
    }
    return FResult.success(
        result.sublist(index + 1, min(index + limit + 1, result.length)));
  }

  @override
  Future<FResult<FRestaurant>> getByFoodId(String foodId) async {
    final query =
        await ref.where('menu', arrayContains: {'food_id': foodId}).get();
    return FResult.success(query.docs.first.data());
  }
}

double _calulateRelativeDistance(
  double lat1,
  double lat2,
  double lon1,
  double lon2,
) {
  return sqrt(pow(lat1 - lat2, 2) + pow(lon1 - lon2, 2));
}
