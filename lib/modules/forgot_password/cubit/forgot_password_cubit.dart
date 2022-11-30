import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../login/models/email_input.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends FCubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._authRepository)
      : super(const ForgotPasswordState());

  final AuthRepository _authRepository;

  void sendResetPasswordEmail() async {
    emitLoading();
    final result = await _authRepository.resetPassword(state.email.value);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state.copyWith(isEmailSent: true));
  }

  void onEmailChanged(String update) {
    emitValue(state.copyWith(email: EmailInput.dirty(update)));
  }

  String? validateEmail() {
    return state.email.valid ? null : state.email.error!.toErrorText();
  }
}
