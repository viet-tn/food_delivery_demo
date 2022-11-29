import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/text_style.dart';
import '../../utils/ui/gradient_text.dart';

class FTextButton extends StatelessWidget {
  const FTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: GradientText(
        text,
        gradient: FColors.linearGradient,
        style: FTextStyles.button,
      ),
    );
  }
}
