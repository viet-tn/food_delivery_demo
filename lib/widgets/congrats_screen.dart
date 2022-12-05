import 'package:flutter/material.dart';

import '../constants/ui/colors.dart';
import '../constants/ui/sizes.dart';
import '../constants/ui/text_style.dart';
import '../gen/assets.gen.dart';
import '../utils/ui/gradient_text.dart';
import '../utils/ui/scaffold.dart';
import 'buttons/gradient_button.dart';

class CongratsParams {
  const CongratsParams({
    this.content = 'Your Profile Is Ready To Use',
    this.buttonLabel = 'Try Order',
    this.onPressed,
  });

  final String content;
  final String buttonLabel;
  final VoidCallback? onPressed;
}

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({
    super.key,
    required this.params,
  });

  final CongratsParams params;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FScaffold(
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
              Text(
                params.content,
                textAlign: TextAlign.center,
                style: FTextStyles.heading2,
              ),
            ],
          ),
        ),
        centerBottomButton: GradientButton(
          onPressed: params.onPressed,
          child: Text(
            params.buttonLabel,
            style: FTextStyles.button,
          ),
        ),
      ),
    );
  }
}
