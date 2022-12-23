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
      [FRestaurant? restaurant, int limit = 5]) async {
    try {
      late QuerySnapshot<FRestaurant> querySnapshot;
      if (restaurant == null) {
        querySnapshot = await ref.orderBy('name').limit(limit).get();
      } else {
        final documentSnapshot = await ref.doc(restaurant.id).get();

        querySnapshot = await ref
            .orderBy('name')
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FRestaurant>[]);
      }
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
