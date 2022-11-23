import 'package:formz/formz.dart';

enum SignUpPasswordValidationError {
  empty,
  shortPassword,
  notMatch;

  String toErrorText() {
    switch (this) {
      case SignUpPasswordValidationError.empty:
        return 'Please input your password!';
      case SignUpPasswordValidationError.shortPassword:
        return 'Password must contains at least 6 characters!';
      case SignUpPasswordValidationError.notMatch:
        return 'Password doesn\'t match!';
    }
  }
}

class SignUpPasswordInput
    extends FormzInput<String, SignUpPasswordValidationError> {
  const SignUpPasswordInput.pure() : super.pure('');
  const SignUpPasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  SignUpPasswordValidationError? validator(String value) {
    if (value.isEmpty == true) return SignUpPasswordValidationError.empty;

    if (value.length < 5) {
      return SignUpPasswordValidationError.shortPassword;
    }
    return null;
  }
}
