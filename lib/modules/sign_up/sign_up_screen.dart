import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/forms/sign_up_form.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/loading_screen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/text_button.dart';
import 'cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        return LoadingScreen(
          isLoading: state.status.isLoading,
          child: ListenError<SignUpCubit>(
            child: FScaffold(
              body: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: Ui.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gapH32,
                    SizedBox.square(
                      dimension: Sizes.logoDimension,
                      child: Image.asset(
                        Assets.images.splash.logo.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                    gapH32,
                    const Text(
                      'Sign Up For Free',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    gapH12,
                    SignUpForm(
                      onSubmittedCreateAccount: (email, password) =>
                          context.read<SignUpCubit>().onSubmittedCreateAccount(
                                email: email,
                                password: password,
                                onCreateAccountSuccessful:
                                    FCoordinator.showBioScreen,
                              ),
                    ),
                    gapH12,
                    FTextButton(
                      text: 'Already have an account?',
                      onPressed: () => FCoordinator.showLoginScreen(),
                    ),
                    gapH32,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
