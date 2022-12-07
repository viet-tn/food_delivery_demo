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
        final documentSnapshot = await ref
            .where('id', isEqualTo: food.id)
            .get()
            .then((value) => value.docs.isNotEmpty ? value.docs.first : null);

        if (documentSnapshot == null) {
          return FResult.success(const <FFood>[]);
        }
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
      final documentSnapshot =
          await ref.where('id', isEqualTo: foodId).limit(1).get();
      return FResult.success(documentSnapshot.docs.first.data());
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<List<FFood>>> fetchFoodsByIds(List<String> foodIds) async {
    if (foodIds.isEmpty) return FResult.success([]);

    final batches = <FFood>[];

    List<List<String>> subList = [];
    for (var i = 0; i < foodIds.length; i += 10) {
      subList.add(
        foodIds.sublist(i, i + 10 > foodIds.length ? foodIds.length : i + 10),
      );
    }

    try {
      for (var sub in subList) {
        final query = await ref.where('id', whereIn: sub).get();
        batches.addAll(query.docs.map((e) => e.data()));
      }
      return FResult.success(batches);
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
