import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/cloud_storage/cloud_storage.dart';
import '../../../repositories/users/coordinate.dart';
import '../../../repositories/users/user_model.dart';
import '../../../repositories/users/user_repository.dart';
import '../../cubits/app/app_cubit.dart';
import '../../login/cubit/login_cubit.dart';
import '../../login/models/email_input.dart';
import '../models/sign_up_password_input.dart';

part 'sign_up_state.dart';

class SignUpCubit extends FCubit<SignUpState> {
  SignUpCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required CloudStorage cloudStorage,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _cloudStorage = cloudStorage,
        super(const SignUpState(status: ScreenStatus.value));

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final CloudStorage _cloudStorage;

  void onChangeEmail(String value) {
    emit(state.copyWith(email: EmailInput.dirty(value)));
  }

  void onChangePaswword(String value) {
    emit(state.copyWith(password: SignUpPasswordInput.dirty(value)));
  }

  Future<void> onSubmittedCreateAccount(
      {required String email,
      required String password,
      required void Function() onCreateAccountSuccessful}) async {
    emitLoading();
    final result = await _authRepository.createUserWithEmailAndPassword(
        email: email, password: password);

    if (result.isError) {
      return emitError(result.error!);
    }
    emitValue();

    final loginCubit = GetIt.I<LoginCubit>();
    loginCubit.onCreateUserOnAuthenDbSuccess(result.data!);
    emit(state.copyWith(user: loginCubit.state.user.copyWith(email: email)));
    onCreateAccountSuccessful();
  }

  Future<void> onBioSubmitted(
    String firstName,
    String lastName,
    String phone, {
    required void Function() onCodeSentSuccess,
  }) async {
    emitLoading();
    final update = state.user.copyWith(
      id: _authRepository.currentUser!.id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
    );
    emitValue(state.copyWith(user: update));
    await verifyPhoneNumber(onCodeSentSuccess);
  }

  Future<void> verifyPhoneNumber(void Function() onCodeSentSuccess) async {
    emitLoading();
    return await _authRepository.verifyPhoneNumber(
      phoneNumber: state.user.phone!,
      onCodeSent: (verificationId) {
        emitValue(state.copyWith(
          verificationId: verificationId,
        ));
        onCodeSentSuccess();
      },
      onVerificationFailed: (e) {
        emitError((e as FirebaseAuthException).message!);
      },
    );
  }

  Future<void> onOtpPhoneConfirm(String otp,
      {required void Function() onOtpPassed}) async {
    emitLoading();
    final result = await _authRepository.otpConfirm(
        verificationId: state.verificationId!, otp: otp);
    if (result.isError) {
      return emitError(result.error!);
    }

    emitValue(state.copyWith(user: state.user.copyWith(isVerified: true)));
    onOtpPassed();
  }

  void onSelectImageComplete(String imgPath,
      {required void Function() onUploadAvatarCompleted}) async {
    emitLoading();
    try {
      final imgUrl = await _cloudStorage.uploadAvatar(state.user.id, imgPath);

      emitValue(
        state.copyWith(
          user: state.user.copyWith(
            photo: imgUrl ?? '',
          ),
        ),
      );
      onUploadAvatarCompleted();
    } catch (e) {
      emitError(e.runtimeType.toString());
    }
  }

  void onSetLocationButtonPressed(double lat, double lon, String address) {
    emitValue(
      state.copyWith(
        user: state.user.copyWith(
          coordinates: <Coordinate>[
            Coordinate(
              latitude: lat,
              longitude: lon,
              address: address,
            )
          ],
        ),
      ),
    );
  }

  bool onSetLocationComplete() {
    if (state.user.coordinates.isEmpty) {
      emitError('Please set your location');
      emitValue();
      return false;
    }
    return true;
  }

  Future<void> onSignUpComplete(void Function() onSignUpCompleted) async {
    emitLoading();
    final result = await _userRepository.set(state.user);

    if (result.isError) {
      return emitError(result.error!);
    }
    emitValue();

    GetIt.I<AppCubit>().init(result.data!);
    final loginCubit = GetIt.I<LoginCubit>();
    loginCubit.emitValue(loginCubit.state.copyWith(user: result.data!));
    onSignUpCompleted();
  }
}
