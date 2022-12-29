import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/ui_parameters.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    super.key,
    required this.logoPath,
    required this.onPressed,
    this.isChoose = false,
  });

  final bool isChoose;
  final String logoPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: Ui.borderRadius,
        border: Border.all(color: FColors.green),
        gradient: isChoose ? FColors.linearGradient : null,
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: Ui.borderRadius,
        splashColor: FColors.green,
        child: Center(
          child: Image.asset(
            logoPath,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
