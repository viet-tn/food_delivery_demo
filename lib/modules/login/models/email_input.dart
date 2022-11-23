import 'package:formz/formz.dart';

enum EmailValidationError {
  empty,
  invalidEmail;

  String toErrorText() {
    switch (this) {
      case EmailValidationError.empty:
        return 'Please input your email!';
      case EmailValidationError.invalidEmail:
        return 'Invalid email';
    }
  }
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty == true) return EmailValidationError.empty;

    bool isValidEmail = RegExp('^\\S+@\\S+\\.\\S+\$').hasMatch(value ?? '');

    if (!isValidEmail) return EmailValidationError.invalidEmail;
    return null;
  }
}
