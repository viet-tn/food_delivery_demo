import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/text_style.dart';

class FAlertDialog extends StatelessWidget {
  const FAlertDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: FTextStyles.heading3.copyWith(color: FColors.lightGreen),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Cancel',
            style: FTextStyles.button.copyWith(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text(
            'OK',
            style: FTextStyles.button.copyWith(color: FColors.green),
          ),
        ),
      ],
    );
  }
}
