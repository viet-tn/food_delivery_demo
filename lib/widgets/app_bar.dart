import 'package:flutter/material.dart';

import '../config/routes/coordinator.dart';
import '../constants/ui/text_style.dart';
import 'buttons/back_button.dart';

class FAppBar extends StatelessWidget {
  const FAppBar({
    super.key,
    required this.title,
    this.onPressed,
  });

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.fromHeight(60.0),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          FCoordinator.canPop()
              ? FBackButton(
                  onPressed: onPressed,
                )
              : const SizedBox(),
          Center(
            child: Text(
              title,
              style: FTextStyles.heading3.copyWith(
                color: const Color(0xFF754B30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
