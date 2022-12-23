import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';

class EditableSectionBar extends StatelessWidget {
  const EditableSectionBar({
    super.key,
    required this.title,
    this.onEditPressed,
  });

  final String title;
  final VoidCallback? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: FTextStyles.heading5.copyWith(
            color: const Color(0xFF754B30),
            fontWeight: FontWeight.w600,
          ),
        ),
        ElevatedButton(
          onPressed: onEditPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            backgroundColor: FColors.backButtonBgColor.withOpacity(.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            'Edit',
            style: FTextStyles.button.copyWith(
              color: const Color(0xFFF56E1B),
            ),
          ),
        ),
      ],
    );
  }
}
