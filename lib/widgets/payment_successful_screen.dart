import 'package:flutter/material.dart';

import '../constants/ui/colors.dart';
import '../constants/ui/sizes.dart';
import '../constants/ui/text_style.dart';
import '../constants/ui/ui_parameters.dart';
import '../gen/assets.gen.dart';
import '../utils/ui/scaffold.dart';
import 'buttons/gradient_button.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({super.key});

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
                child: Image.asset(Assets.images.illustrations.payment.path),
              ),
              const Text(
                'Payment Success',
                style: FTextStyles.heading2,
              ),
              const Text(
                'Your payment was successful!',
              ),
              const Spacer(),
              Padding(
                padding: Ui.screenPaddingHorizontal,
                child: Column(
                  children: [
                    GradientButton(
                      width: double.infinity,
                      onPressed: () {},
                      child: const Text(
                        'Track order status',
                        style: FTextStyles.button,
                      ),
                    ),
                    gapH12,
                    SizedBox.fromSize(
                      size: const Size.fromHeight(60.0),
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: FColors.green),
                        ),
                        child: Text(
                          'Back to Home',
                          style: FTextStyles.button.copyWith(
                            color: FColors.green,
                          ),
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
