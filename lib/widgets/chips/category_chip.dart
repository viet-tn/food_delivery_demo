import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/text_style.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.text,
    this.padding = const EdgeInsets.all(10),
    this.textStyle,
  });

  final String text;
  final EdgeInsets padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: FColors.lightGreen.withOpacity(.2),
      padding: padding,
      label: Text(
        text,
        style: textStyle ??
            FTextStyles.label.copyWith(
              color: FColors.green,
            ),
      ),
    );
  }
}
