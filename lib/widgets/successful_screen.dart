import 'package:flutter/material.dart';

import '../config/routes/coordinator.dart';
import '../constants/ui/sizes.dart';
import '../constants/ui/text_style.dart';
import '../constants/ui/ui_parameters.dart';
import '../gen/assets.gen.dart';
import '../utils/ui/scaffold.dart';
import 'buttons/gradient_button.dart';

class SuccessfulScreen extends StatelessWidget {
  const SuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FScaffold(
        body: SizedBox.expand(
          child: Column(
            children: [
              SizedBox.square(
                dimension: 300.0,
                child: Image.asset(Assets.icons.congrats.path),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: const [
                    Text(
                      'You Place The Order Successfully',
                      textAlign: TextAlign.center,
                      style: FTextStyles.heading3,
                    ),
                    gapH24,
                    Text(
                      'Your order is placed successfully. We start our delivery process and you will receive your food soon',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: Ui.screenPaddingHorizontal,
                child: Column(
                  children: [
                    SizedBox.fromSize(
                      size: const Size.fromHeight(60.0),
                      child: const GradientButton(
                        onPressed: FCoordinator.showHomeScreen,
                        child: Text(
                          'Back to Home',
                          style: FTextStyles.button,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              gapH64,
            ],
          ),
        ),
      ),
    );
  }
}
