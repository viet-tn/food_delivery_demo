import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../utils/ui/drop_shadow.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({
    super.key,
    this.onInputChanged,
  });

  final void Function(String)? onInputChanged;

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      child: InternationalPhoneNumberInput(
        initialValue: PhoneNumber(isoCode: 'VN'),
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        onInputChanged: (value) {
          onInputChanged?.call(value.phoneNumber ?? '');
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          }
          return null;
        },
      ),
    );
  }
}
