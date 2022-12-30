import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_geohash/dart_geohash.dart';
import 'package:path_provider/path_provider.dart';

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
      [FRestaurant? restaurant, int limit = 5, double radius = 40]) async {
    final center = GeoPoint(latitudeSrc, longitudeSrc);
    final geoHash = GeoHasher();

    double latPerKm = 0.00902;
    double lonPerKm = 0.00914;

    double lowerLat = center.latitude - (latPerKm * radius);
    double lowerLon = center.longitude - (lonPerKm * radius);

    double greaterLat = center.latitude + (latPerKm * radius);
    double greaterLon = center.longitude + (lonPerKm * radius);

    String lesserGeoHash = geoHash.encode(lowerLon, lowerLat, precision: 9);
    String greaterGeoHash =
        geoHash.encode(greaterLon, greaterLat, precision: 9);

    late QuerySnapshot<FRestaurant> querySnapshot;
    final geoHashRef = FieldPath(const ['coordinate', 'position', 'geohash']);
    if (restaurant == null) {
      querySnapshot = await ref
          .where(geoHashRef, isGreaterThan: lesserGeoHash)
          .where(geoHashRef, isLessThan: greaterGeoHash)
          .orderBy(geoHashRef)
          .limit(limit)
          .get();
    } else {
      final documentSnapshot = await ref.doc(restaurant.id).get();
      querySnapshot = await ref
          .where(geoHashRef, isGreaterThan: lesserGeoHash)
          .where(geoHashRef, isLessThan: greaterGeoHash)
          .orderBy(geoHashRef)
          .startAfterDocument(documentSnapshot)
          .limit(limit)
          .get();
    }

    if (querySnapshot.docs.isEmpty) {
      return FResult.success(const <FRestaurant>[]);
    }

    final result = querySnapshot.docs.map((e) => e.data()).toList();

    return FResult.success(result);
  }

  @override
  Future<FResult<FRestaurant>> getByFoodId(String foodId) async {
    final query =
        await ref.where('menu', arrayContains: {'food_id': foodId}).get();
    return FResult.success(query.docs.first.data());
  }

  Future<void> exportRestaurants() async {
    final query = await ref.get();
    List<FRestaurant> restaurants = query.docs.map((e) => e.data()).toList();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/restaurants.json');
    for (var restaurant in restaurants) {
      file.writeAsStringSync('${jsonEncode(restaurant.toMap())},',
          mode: FileMode.append);
    }
  }

  @override
  Future<FResult<FRestaurant>> getById(String id) {
    return get(id);
  }
}
