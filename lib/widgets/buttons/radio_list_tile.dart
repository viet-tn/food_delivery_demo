import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/sizes.dart';

class FRadioListTile extends StatelessWidget {
  const FRadioListTile({
    super.key,
    required this.text,
    required this.value,
    required this.onTap,
  });

  final String text;
  final bool value;
  final void Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTap(!value),
          child: value
              ? const Icon(
                  Icons.check_circle,
                  color: FColors.lightGreen,
                )
              : const Icon(
                  Icons.circle_outlined,
                  color: FColors.lightGreen,
                ),
        ),
        gapW8,
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
