import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/text_style.dart';

class FInputChip extends StatelessWidget {
  const FInputChip({
    super.key,
    required this.label,
    this.onDeleted,
  });

  final String label;
  final void Function(String element)? onDeleted;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      backgroundColor: FColors.metallicOrangeO5.withOpacity(.2),
      label: Text(
        label,
        style: FTextStyles.label.copyWith(color: FColors.metallicOrange),
      ),
      onDeleted: () => onDeleted?.call(label),
    );
  }
}
