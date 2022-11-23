import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sign_up_cubit.dart';
import '../widgets/payment_selector.dart';
import '../widgets/sign_up_flow_screen.dart';

class FillPaymentScreen extends StatelessWidget {
  const FillPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpFlowScreen(
      onNextPressed: context.read<SignUpCubit>().onPaymentComplete,
      title: 'Payment Method',
      subTitle:
          'This data will be displayed in your account profile for security',
      child: PaymentSelector(
        onPaymentSelected: context.read<SignUpCubit>().onPaymentMethodSelected,
      ),
    );
  }
}
