part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends FState {
  const ForgotPasswordState({
    super.status = ScreenStatus.value,
    super.errorMessage,
    this.email = const EmailInput.pure(),
    this.isEmailSent = false,
  });

  final EmailInput email;
  final bool isEmailSent;

  @override
  List<Object?> get props => [...super.props, email, isEmailSent];

  @override
  ForgotPasswordState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    EmailInput? email,
    bool? isEmailSent,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      isEmailSent: isEmailSent ?? this.isEmailSent,
    );
  }
}
