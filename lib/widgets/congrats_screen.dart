import 'package:flutter/material.dart';

import '../config/routes/coordinator.dart';
import '../constants/ui/colors.dart';
import '../constants/ui/sizes.dart';
import '../constants/ui/text_style.dart';
import '../gen/assets.gen.dart';
import '../utils/ui/gradient_text.dart';
import '../utils/ui/scaffold.dart';
import 'buttons/gradient_button.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.icons.congrats.path),
            gapH32,
            const GradientText(
              'Congrats!',
              gradient: FColors.linearGradient,
              style: FTextStyles.heading1,
            ),
            gapH12,
            const Text(
              'Your Profile Is Ready To Use',
              textAlign: TextAlign.center,
              style: FTextStyles.heading2,
            ),
          ],
        ),
      ),
      centerBottomButton: GradientButton(
        onPresssed: () {
          FCoordinator.showHomeScreen();
        },
        child: const Text(
          'Try Order',
          style: FTextStyles.button,
        ),
      ),
    );
  }
}
