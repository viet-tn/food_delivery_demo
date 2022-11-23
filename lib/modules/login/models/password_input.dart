import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty;

  String toErrorText() {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Please input your password!';
    }
  }
}

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
