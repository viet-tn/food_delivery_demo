import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';

class MemberChip extends StatelessWidget {
  const MemberChip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: FColors.pastelOrange,
      padding: const EdgeInsets.all(10),
      label: Text(
        text,
        style: FTextStyles.heading5.copyWith(
          color: FColors.darkTangerine,
        ),
      ),
    );
  }
}
