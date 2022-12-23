import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/routes/coordinator.dart';
import '../constants/ui/colors.dart';
import '../constants/ui/sizes.dart';
import '../constants/ui/text_style.dart';
import '../constants/ui/ui_parameters.dart';
import '../gen/assets.gen.dart';
import '../modules/cubits/app/app_cubit.dart';
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
                child: SvgPicture.asset(Assets.images.illustrations.cooking),
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
                    BlocBuilder<AppCubit, AppState>(
                      builder: (context, state) {
                        return GradientButton(
                          width: double.infinity,
                          onPressed: () {
                            FCoordinator.pushNamed(
                              Routes.orderTracking.name,
                              extra: [
                                state.restaurant!.coordinate,
                                state.order!.userPosition,
                              ],
                            );
                          },
                          child: const Text(
                            'Track order status',
                            style: FTextStyles.button,
                          ),
                        );
                      },
                    ),
                    gapH12,
                    SizedBox.fromSize(
                      size: const Size.fromHeight(60.0),
                      child: OutlinedButton(
                        onPressed: FCoordinator.showHomeScreen,
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
