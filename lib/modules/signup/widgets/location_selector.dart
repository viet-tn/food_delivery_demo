import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/ui/drop_shadow.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      shadowColor: Colors.grey[50]!,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset(Assets.icons.pin.path),
                gapW16,
                const Text(
                  'Your Location',
                  style: FTextStyles.buttonBlack,
                ),
              ],
            ),
            gapH32,
            SizedBox(
              height: 60.0,
              child: Ink(
                decoration: const BoxDecoration(
                  color: FColors.setLocationButtonBgColor,
                  borderRadius: Ui.borderRadius,
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: Ui.borderRadius,
                  child: const Center(
                    child: Text(
                      'Set Location',
                      style: FTextStyles.buttonBlack,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
