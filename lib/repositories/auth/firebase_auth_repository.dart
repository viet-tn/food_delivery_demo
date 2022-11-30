import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../result.dart';
import '../users/user_model.dart';
import 'auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  const FirebaseAuthRepository();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  FUser? get currentUser => FUser.fromUser(_firebaseAuth.currentUser);

  @override
  Stream<AuthenStatus> get status async* {
    await for (final user in _firebaseAuth.authStateChanges()) {
      if (user != null) {
        yield AuthenStatus.authenticated;
      } else {
        yield AuthenStatus.unauthenticated;
      }
    }
  }

  @override
  Future<FResult<FUser>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return FResult.success(FUser.fromUserCredential(credential));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<FUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log(credential.toString());
      return FResult.success(FUser.fromUserCredential(credential));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();

  @override
  Future<FResult<FUser>> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return FResult.success(FUser.fromUserCredential(userCredential));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<FUser>> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return FResult.success(FUser.fromUserCredential(userCredential));
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required void Function(String verificationId) onCodeSent,
      required void Function(FirebaseAuthException e)
          onVerificationFailed}) async {
    log(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {},
      verificationFailed: onVerificationFailed,
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('codeAutoRetrievalTimeout');
      },
      timeout: const Duration(minutes: 2),
    );
  }

  @override
  Future<FResult<String>> otpConfirm({
    required String verificationId,
    required String otp,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    late String errorMessage;
    try {
      await _firebaseAuth.currentUser?.linkWithCredential(credential);
      return FResult.success('');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          return FResult.success('');
        case "invalid-credential":
          errorMessage = 'Invalid OTP';
          break;
        case "credential-already-in-use":
          errorMessage = 'Phone already in use';
          break;
        // See the API reference for the full list of error codes.
        default:
          return FResult.error(e.code);
      }
      return FResult.error(errorMessage);
    }
  }

  @override
  Future<FResult<String>> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return FResult.success('');
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<String>> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(cred);
      user.updatePassword(newPassword);
      return FResult.success('');
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
