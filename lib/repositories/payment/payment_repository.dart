import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'payment_model.dart';
import 'stripe.dart';

class PaymentRepository {
  PaymentRepository(this.uid)
      : ref = FirebaseFirestore.instance
            .collection('customers/$uid/checkout_sessions')
            .withConverter<FStripe>(
              fromFirestore: (snapshot, options) =>
                  FStripe.fromMap(snapshot.data()!),
              toFirestore: (order, options) => order.toMap(),
            );

  final String uid;
  final CollectionReference<FStripe> ref;

  Stream<FStripe> createCheckoutSession(FPayment order) async* {
    final doc = await ref.add(FStripe.fromFOrder(order));
    await for (var snapshot in doc.snapshots()) {
      final data = snapshot.data()!;
      if (data.created != null) {
        yield data;
      }
    }
  }

  Stream<FStripe> setup() async* {
    final doc = await ref.add(FStripe());
    await for (var snapshot in doc.snapshots()) {
      final data = snapshot.data()!;
      if (data.created != null) {
        yield data;
      }
    }
  }

  // Future<bool> wasSetUp() async {
  //   final doc = await FirebaseFirestore.instance.collection('order')
  // }
}
