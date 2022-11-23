import 'package:flutter/material.dart';

import '../../constants/ui/text_style.dart';
import '../../utils/ui/drop_shadow.dart';

class FOutlinedIconButton extends StatelessWidget {
  const FOutlinedIconButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
    this.minHeight = 57.0,
    this.minWidth = 152.0,
    this.maxHeight = double.infinity,
    this.maxWidth = double.infinity,
  });

  final String label;
  final String iconPath;
  final VoidCallback onPressed;
  final double minWidth;
  final double minHeight;
  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight,
        minWidth: minWidth,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
      ),
      child: DropShadow(
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: Image.asset(
            iconPath,
            fit: BoxFit.contain,
          ),
          label: Text(
            label,
            style: FTextStyles.button.copyWith(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
