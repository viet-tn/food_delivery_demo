import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../repositories/base_collection_reference.dart';
import '../../../repositories/result.dart';
import '../model/order.dart';

class OrderRepository extends BaseCollectionReference<FOrder> {
  OrderRepository(this.uid)
      : super(
          FirebaseFirestore.instance
              .collection("users/$uid/orders")
              .withConverter<FOrder>(
                fromFirestore: (snapshot, _) =>
                    FOrder.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (food) => food.id!,
          setID: (food, id) => food.copyWith(id: id),
        );

  final String uid;

  Future<FResult<FOrder>> create(FOrder order) {
    return set(order);
  }

  Future<FResult<List<FOrder>>> fetchOrdersByStatus(
    OrderStatus status, [
    FOrder? order,
    int limit = 10,
  ]) async {
    try {
      late QuerySnapshot<FOrder> querySnapshot;
      if (order == null) {
        querySnapshot = await ref
            .orderBy('created', descending: true)
            .where('status', isEqualTo: status.name)
            .limit(limit)
            .get();
      } else {
        final documentSnapshot = await ref.doc(order.id).get();

        querySnapshot = await ref
            .orderBy('created', descending: true)
            .where('status', isEqualTo: status.name)
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FOrder>[]);
      }
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<List<FOrder>>> fetchAllOrders([
    FOrder? order,
    int limit = 10,
  ]) async {
    try {
      late QuerySnapshot<FOrder> querySnapshot;
      if (order == null) {
        querySnapshot =
            await ref.orderBy('created', descending: true).limit(limit).get();
      } else {
        final documentSnapshot = await ref.doc(order.id).get();

        querySnapshot = await ref
            .orderBy('created', descending: true)
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }
      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FOrder>[]);
      }
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
