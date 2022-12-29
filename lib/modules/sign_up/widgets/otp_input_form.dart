import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../utils/ui/drop_shadow.dart';

const otpLetterCount = 6;

class OtpInputForm extends StatelessWidget {
  const OtpInputForm({
    super.key,
    required this.onOtpChanged,
  });

  final void Function(String) onOtpChanged;

  @override
  Widget build(BuildContext context) {
    final otp = List.generate(otpLetterCount, (_) => '');
    return Form(
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            otpLetterCount,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: LetterInput(
                onLetterChanged: (char) {
                  otp[index] = char;
                  onOtpChanged(otp.join());
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LetterInput extends StatelessWidget {
  const LetterInput({
    super.key,
    this.onLetterChanged,
  });

  final void Function(String)? onLetterChanged;

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      elevation: 2.0,
      shadowColor: FColors.lightGreen,
      child: SizedBox(
        height: 70,
        width: 60,
        child: TextFormField(
          onChanged: (value) {
            if (value.length == 1) {
              onLetterChanged?.call(value);
              FocusScope.of(context).nextFocus();
            }

            if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          textAlign: TextAlign.center,
          style: FTextStyles.verificationCode,
        ),
      ),
    );
  }
}
