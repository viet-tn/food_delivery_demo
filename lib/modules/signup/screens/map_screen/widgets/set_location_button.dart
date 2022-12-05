import 'package:flutter/material.dart';

import '../../../../../constants/ui/sizes.dart';
import '../../../../../constants/ui/text_style.dart';
import '../../../../../constants/ui/ui_parameters.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/buttons/gradient_button.dart';

class SetLocationButton extends StatelessWidget {
  const SetLocationButton({
    super.key,
    this.isLoading = false,
    this.location,
    this.onPressed,
  });

  final bool isLoading;
  final String? location;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 28.0),
      padding: const EdgeInsets.all(12.0),
      decoration: const BoxDecoration(
        borderRadius: Ui.borderRadius,
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your location',
            style: FTextStyles.label.copyWith(color: Colors.grey),
          ),
          gapH12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(Assets.icons.pin.path),
              gapW12,
              Expanded(
                child: Text(
                  location ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.heading5,
                ),
              ),
            ],
          ),
          gapH12,
          GradientButton(
            onPressed: isLoading ? null : onPressed,
            width: double.infinity,
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    'Set Location',
                    style: FTextStyles.button,
                  ),
          )
        ],
      ),
    );
  }
}
