import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../widgets/textfield/text_field.dart';
import 'phone_input.dart';

class BioForm extends StatelessWidget {
  const BioForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    this.onPhoneNumberChanged,
    this.formKey,
  });

  final Key? formKey;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  final void Function(String phone)? onPhoneNumberChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(
        children: [
          FTextField(
            controller: firstNameController,
            labelText: 'First Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          gapH12,
          FTextField(
            controller: lastNameController,
            labelText: 'Last Name',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          gapH12,
          PhoneInput(
            onInputChanged: onPhoneNumberChanged,
          ),
        ],
      ),
    );
  }
}
