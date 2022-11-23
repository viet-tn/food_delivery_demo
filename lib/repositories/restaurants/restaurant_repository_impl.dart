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
  Future<FResult<List<FRestaurant>>> fetchNearestRestaurant(
      [int limit = 5]) async {
    try {
      final querySnapshot = await ref.limit(limit).get();
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e.runtimeType.toString());
    }
  }
}
