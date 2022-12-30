part of 'login_cubit.dart';

class LoginState extends FState {
  const LoginState({
    super.status = ScreenStatus.value,
    super.errorMessage,
    this.user = FUser.empty,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
  });

  final FUser user;
  final EmailInput email;
  final PasswordInput password;

  @override
  List<Object?> get props => [...super.props, user, email, password];

  @override
  LoginState copyWith({
    ScreenStatus? status,
    FUser? user,
    EmailInput? email,
    PasswordInput? password,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      email: email ?? this.email,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
