import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../result.dart';
import 'notification.dart';

class NotificationRepository {
  NotificationRepository(
    this._messaging,
    this._firestore,
  );

  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;

  Future<FResult<List<FNotification>>> fetch(String uid,
      [FNotification? notification, int limit = 10]) async {
    try {
      final notificationRef = _firestore.collection('notifications');

      late final QuerySnapshot<Map<String, dynamic>> querySnapshot;

      if (notification == null) {
        querySnapshot = await notificationRef
            .where('uid', isEqualTo: uid)
            .orderBy('created', descending: true)
            .limit(limit)
            .get();
      } else {
        final documentSnapshot =
            await notificationRef.doc(notification.id).get();
        querySnapshot = await notificationRef
            .where('uid', isEqualTo: uid)
            .orderBy('created', descending: true)
            .startAfterDocument(documentSnapshot)
            .limit(limit)
            .get();
      }

      if (querySnapshot.docs.isEmpty) {
        return FResult.success(const <FNotification>[]);
      }

      return FResult.success(
        querySnapshot.docs
            .map((e) => FNotification.fromJson(e.data()))
            .toList(),
      );
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<String>> getToken() async {
    try {
      final token = await _messaging.getToken();
      return FResult.success(token!);
    } catch (e) {
      return FResult.exception(e);
    }
  }

  Future<FResult<String>> saveToken(String uid, String token) async {
    try {
      await _firestore.collection('notification_tokens').doc(uid).set({
        'token': token,
        'created': DateTime.now(),
      });
      return FResult.success('');
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
