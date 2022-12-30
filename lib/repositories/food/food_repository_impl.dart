import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../base_collection_reference.dart';
import '../result.dart';
import 'food_model.dart';
import 'food_repository.dart';

class FoodRepositoryImpl extends BaseCollectionReference<FFood>
    implements FoodRepository {
  FoodRepositoryImpl()
      : super(
          FirebaseFirestore.instance.collection("foods").withConverter<FFood>(
                fromFirestore: (snapshot, _) => FFood.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (food) => food.id,
          setID: (food, id) => food.copyWith(id: id),
        );

  @override
  Future<FResult<List<FFood>>> fetchFoods([FFood? food, int limit = 10]) async {
    try {
      late QuerySnapshot<FFood> querySnapshot;
      if (food == null) {
        querySnapshot =
            await ref.orderBy('id', descending: true).limit(limit).get();
      } else {
        final documentSnapshot = await ref.doc(food.id).get();

        querySnapshot = await ref
            .orderBy('id', descending: true)
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FFood>[]);
      }
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<FFood>> fetchFoodById(String foodId) async {
    try {
      final documentSnapshot = await ref.doc(foodId).get();

      return documentSnapshot.exists
          ? FResult.success(documentSnapshot.data())
          : FResult.error('food not found');
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<List<FFood>>> fetchFoodsByIds(List<String> foodIds,
      [FFood? food, int limit = 10]) async {
    assert(limit <= 10);
    if (foodIds.isEmpty) return FResult.success(const <FFood>[]);

    foodIds = foodIds..sort((a, b) => a.compareTo(b));

    late final int startIndex;
    if (food == null) {
      startIndex = 0;
    } else {
      startIndex = foodIds.indexOf(food.id) + 1;
    }

    final subList =
        foodIds.sublist(startIndex, min(startIndex + limit, foodIds.length));

    if (subList.isEmpty) return FResult.success(const <FFood>[]);

    try {
      final query = await ref.where('id', whereIn: subList).get();
      return FResult.success(query.docs.map((e) => e.data()).toList()
        ..sort(
          (a, b) => a.id.compareTo(b.id),
        ));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<List<FFood>>> fetchPopularFoods(
      [FFood? food, int limit = 10]) async {
    try {
      late QuerySnapshot<FFood> querySnapshot;
      if (food == null) {
        querySnapshot = await ref
            .orderBy('name')
            .where('category', isEqualTo: 'best-foods')
            .limit(limit)
            .get();
      } else {
        final documentSnapshot = await ref
            .where('id', isEqualTo: food.id)
            .get()
            .then((value) => value.docs.isNotEmpty ? value.docs.first : null);

        if (documentSnapshot == null) {
          return FResult.success(const <FFood>[]);
        }
        querySnapshot = await ref
            .orderBy('name')
            .where('category', isEqualTo: 'best-foods')
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FFood>[]);
      }
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
