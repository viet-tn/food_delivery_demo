part of 'sign_up_cubit.dart';

class SignUpState extends FState {
  const SignUpState({
    super.status,
    super.errorMessage,
    this.email = const EmailInput.pure(),
    this.password = const SignUpPasswordInput.pure(),
    this.user = FUser.empty,
    this.verificationId,
    this.address,
  });

  final EmailInput email;
  final SignUpPasswordInput password;
  final FUser user;
  final String? verificationId;
  final String? address;

  @override
  List<Object?> get props => [
        ...super.props,
        email,
        password,
        user,
        verificationId,
        address,
      ];

  @override
  SignUpState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    EmailInput? email,
    SignUpPasswordInput? password,
    FUser? user,
    String? verificationId,
    String? address,
  }) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
      verificationId: verificationId ?? this.verificationId,
      address: address ?? this.address,
    );
  }
}
