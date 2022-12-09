import 'package:cloud_firestore/cloud_firestore.dart';

import 'result.dart';

typedef GetID<T> = String Function(T item);
typedef SetID<T> = T Function(T item, String id);

class BaseCollectionReference<T> {
  BaseCollectionReference(
    this.ref, {
    required this.getID,
    required this.setID,
  });

  final CollectionReference<T> ref;
  GetID<T> getID;
  SetID<T> setID;

  Future<FResult<T>> get(String id) async {
    try {
      final DocumentSnapshot<T> doc = await ref.doc(id).get();
      if (doc.exists) {
        return FResult.success(doc.data());
      } else {
        return FResult.error('Item does not exist');
      }
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<String>> delete(String id) async {
    try {
      await ref.doc(id).delete();
      return FResult.success('');
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Stream<DocumentSnapshot<T>> snapshots(String id) {
    return ref.doc(id).snapshots();
  }

  Future<FResult<T>> add(T item) async {
    try {
      final DocumentReference<T> doc =
          await ref.add(item).timeout(const Duration(seconds: 5));
      await doc.update({'id': doc.id});
      return FResult.success(setID(item, doc.id));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<T>> set(T item, {bool merge = true}) async {
    try {
      await ref.doc(getID(item)).set(item, SetOptions(merge: merge));
      // .timeout(const Duration(seconds: 5));
      return FResult.success(item);
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<List<T>>> query() async {
    try {
      final QuerySnapshot<T> query =
          await ref.get().timeout(const Duration(seconds: 5));
      final docs = query.docs.map((e) => e.data()).toList();
      return FResult.success(docs);
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
