import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/forms/reset_password_form.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/back_button.dart';
import 'cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ForgotPasswordCubit>(),
      child: ListenError<ForgotPasswordCubit>(
        child: FScaffold(
          body: Padding(
            padding: Ui.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FBackButton(),
                gapH12,
                const Text(
                  'Reset Password',
                  style: FTextStyles.heading2,
                ),
                gapH32,
                Text(
                  'Enter the email associated with your account and we\'ll send an email with instructions to reset your password.',
                  style: FTextStyles.body.copyWith(color: Colors.black87),
                ),
                gapH20,
                BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listenWhen: (previous, current) =>
                      previous.isEmailSent != current.isEmailSent,
                  listener: (context, state) {
                    if (state.isEmailSent) {
                      FCoordinator.pushNamed(
                          Routes.resetPasswordEmailSent.name);
                    }
                  },
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return ResetPasswordForm(
                      isLoading: state.status.isLoading,
                      onEmailChanged:
                          context.read<ForgotPasswordCubit>().onEmailChanged,
                      onSubmit: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context
                            .read<ForgotPasswordCubit>()
                            .sendResetPasswordEmail();
                      },
                      validateEmail:
                          context.read<ForgotPasswordCubit>().validateEmail,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
