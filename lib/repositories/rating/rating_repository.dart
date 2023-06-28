import 'package:cloud_firestore/cloud_firestore.dart';

import '../base_collection_reference.dart';
import '../result.dart';
import 'rating.dart';
import 'star/star.dart';

class RatingRepository extends BaseCollectionReference<FRating> {
  RatingRepository(this._firestore)
      : super(
          _firestore.collection('ratings').withConverter<FRating>(
                fromFirestore: (snapshot, options) =>
                    FRating.fromJson(snapshot.data()!),
                toFirestore: (value, options) => value.toJson(),
              ),
          getID: (rating) => rating.id!,
          setID: (rating, id) => rating.copyWith(id: id),
        );

  final FirebaseFirestore _firestore;

  Future<FResult<List<FRating>>> fetchRatingsByFoodId(String foodId,
      [FRating? rating, int limit = 5]) async {
    try {
      late QuerySnapshot<FRating> querySnapshot;
      if (rating == null) {
        querySnapshot = await ref
            .where('foodId', isEqualTo: foodId)
            .orderBy('created', descending: true)
            .limit(limit)
            .get();
      } else {
        final documentSnapshot = await ref.doc(rating.id).get();

        querySnapshot = await ref
            .where('foodId', isEqualTo: foodId)
            .orderBy('created', descending: true)
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FRating>[]);
      }
      final ratings = querySnapshot.docs.map((e) => e.data()).toList();

      return FResult.success(await _addReviewerInformation(ratings));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<List<FRating>>> fetchRatingsByRestaurantId(String restaurantId,
      [FRating? rating, int limit = 5]) async {
    try {
      late QuerySnapshot<FRating> querySnapshot;
      if (rating == null) {
        querySnapshot = await ref
            .where('restaurantId', isEqualTo: restaurantId)
            .orderBy('created', descending: true)
            .limit(limit)
            .get();
      } else {
        final documentSnapshot = await ref.doc(rating.id).get();

        querySnapshot = await ref
            .where('restaurantId', isEqualTo: restaurantId)
            .orderBy('created', descending: true)
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FRating>[]);
      }

      final ratings = querySnapshot.docs.map((e) => e.data()).toList();

      return FResult.success(await _addReviewerInformation(ratings));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<FRating>> add(FRating item) async {
    try {
      final ratingCountRef =
          _firestore.collection('ratingCounts').doc(item.restaurantId);
      var documentSnapshot = await ratingCountRef.get();

      if (!documentSnapshot.exists) {
        await ratingCountRef
            .set({item.foodId: const FStar().increment(item.rate).toJson()});
        documentSnapshot = await ratingCountRef.get();
      }

      final starUpdate = FStar.fromJson(
        documentSnapshot.data()?[item.foodId] ?? const FStar().toJson(),
      ).increment(item.rate);

      ratingCountRef.update({item.foodId: starUpdate.toJson()});
      return super.add(item);
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<List<FRating>> _addReviewerInformation(List<FRating> ratings) async {
    final result = <FRating>[];
    for (var rating in ratings) {
      final userDocumentSnapshot =
          await _firestore.collection('users').doc(rating.uid).get();
      final userData = userDocumentSnapshot.data()!;
      result.add(rating.copyWith(
        userPhotoUrl: userData['photo'],
        name: userData['firstName'] + ' ' + userData['lastName'],
      ));
    }
    return result;
  }
}
