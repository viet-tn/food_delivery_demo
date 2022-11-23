import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/text_style.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: FColors.lightGreen.withOpacity(.2),
      padding: const EdgeInsets.all(10),
      label: Text(
        text,
        style: FTextStyles.label.copyWith(
          color: FColors.green,
        ),
      ),
    );
  }
}
