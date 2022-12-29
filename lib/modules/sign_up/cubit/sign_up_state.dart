part of 'sign_up_cubit.dart';

class SignUpState extends FState {
  const SignUpState({
    super.status = ScreenStatus.value,
    super.errorMessage,
    this.email = const EmailInput.pure(),
    this.password = const SignUpPasswordInput.pure(),
    this.user = FUser.empty,
    this.verificationId,
  });

  final EmailInput email;
  final SignUpPasswordInput password;
  final FUser user;
  final String? verificationId;

  @override
  List<Object?> get props => [
        ...super.props,
        email,
        password,
        user,
        verificationId,
      ];

  @override
  SignUpState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    EmailInput? email,
    SignUpPasswordInput? password,
    FUser? user,
    String? verificationId,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      verificationId: verificationId ?? this.verificationId,
    );
  }
}
