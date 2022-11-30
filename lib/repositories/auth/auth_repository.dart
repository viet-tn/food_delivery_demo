import '../result.dart';
import '../users/user_model.dart';

enum AuthenStatus { authenticated, unauthenticated }

abstract class AuthRepository {
  Stream<AuthenStatus> get status;

  FUser? get currentUser;

  Future<FResult<FUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<FResult<FUser>> signInWithGoogle();

  Future<FResult<FUser>> signInWithFacebook();

  Future<FResult<FUser>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(String verificationId) onCodeSent,
    required void Function(Exception e) onVerificationFailed,
  });

  Future<FResult<String>> otpConfirm({
    required String verificationId,
    required String otp,
  });

  Future<FResult<String>> resetPassword(String email);
  Future<FResult<String>> changePassword(
    String currentPassword,
    String newPassword,
  );

  Future<void> signOut();

  Future<FResult<String>> deleteUser();
}
