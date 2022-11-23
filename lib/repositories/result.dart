import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class FResult<T> {
  T? data;
  String? error;

  bool get isError => error != null;
  bool get isSuccess => error == null && data != null;

  FResult.success(this.data) {
    error = null;
  }

  FResult.error(String? error) {
    data = null;
    this.error = error ?? 'An Unknown Error Occurred';
  }

  FResult.exception(Object? e) {
    data = null;
    if (e is PlatformException) {
      error = e.message;
    } else if (e is AssertionError) {
      error = e.message?.toString();
    } else if (e is FirebaseAuthException) {
      error = e.message;
    } else if (e is FirebaseException) {
      error = e.message;
    }
    error ??= e.runtimeType.toString();
  }
}
