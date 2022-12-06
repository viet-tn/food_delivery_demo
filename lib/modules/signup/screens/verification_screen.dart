import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/routes/coordinator.dart';

import '../../../utils/helpers/text_helpers.dart';
import '../../../utils/ui/listen_error.dart';
import '../../../utils/ui/snack_bar.dart';
import '../cubit/sign_up_cubit.dart';
import '../widgets/otp_input_form.dart';
import '../widgets/sign_up_flow_screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String otp = '';
    return ListenError<SignUpCubit>(
      child: SignUpFlowScreen(
        onNextPressed: () async {
          if (otp.length == otpLetterCount) {
            await context.read<SignUpCubit>().onOtpPhoneConfirm(otp,
                onOtpPassed: FCoordinator.showUploadPhotoScreen);
          } else {
            FSnackBar.showSnackBar('Please enter valid OTP');
          }
        },
        title: 'Enter $otpLetterCount-digit Verification code',
        subTitle:
            'Code send to ${context.read<SignUpCubit>().state.user.phone!.hideLastXChar(4)}. This code will expired in 01:30.',
        child: OtpInputForm(
          onOtpChanged: (value) => otp = value,
        ),
      ),
    );
  }
}
