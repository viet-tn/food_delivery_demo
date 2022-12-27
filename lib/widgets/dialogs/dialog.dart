import 'package:flutter/material.dart';

import '../../constants/ui/ui.dart';
import '../buttons/gradient_button.dart';
import '../buttons/outlined_button.dart';

class FAlertDialog extends StatelessWidget {
  const FAlertDialog({
    super.key,
    required this.title,
    this.description,
    this.onYesPressed,
    this.onNoPressed,
  });

  final String title;
  final String? description;
  final VoidCallback? onNoPressed;
  final VoidCallback? onYesPressed;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: Ui.borderRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gapH16,
          const Icon(
            Icons.error_rounded,
            color: FColors.metallicOrange,
            size: 60.0,
          ),
          gapH16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: FTextStyles.heading4.copyWith(
                    color: FColors.metallicOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                description == null
                    ? const SizedBox()
                    : Column(
                        children: [
                          gapH24,
                          Text(
                            description!,
                            style: FTextStyles.body,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
              ],
            ),
          ),
          gapH24,
          Row(
            children: [
              gapW16,
              Expanded(
                child: FOutlinedButton(
                  onPressed: onNoPressed ?? () => Navigator.pop(context),
                  label: 'No',
                ),
              ),
              gapW16,
              Expanded(
                child: GradientButton(
                  onPressed: onYesPressed ?? () => Navigator.pop(context),
                  gradient: const LinearGradient(colors: [
                    FColors.metallicOrange,
                    FColors.metallicOrange,
                  ]),
                  child: const Text(
                    'Yes',
                    style: FTextStyles.button,
                  ),
                ),
              ),
              gapW16,
            ],
          ),
          gapH24,
        ],
      ),
    );
  }
}
