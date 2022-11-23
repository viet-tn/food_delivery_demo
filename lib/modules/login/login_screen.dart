import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/forms/login_form.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/loading_screen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/outlined_icon_button.dart';
import '../../widgets/buttons/text_button.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (_, state) {
        return LoadingScreen(
          isLoading: state.status.isLoading,
          child: ListenError<LoginCubit>(
            child: FScaffold(
              body: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: Ui.screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gapH64,
                    Image.asset(
                      Assets.images.splash.logo.path,
                      fit: BoxFit.cover,
                    ),
                    gapH64,
                    const Text(
                      'Login To Your Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    gapH48,
                    LoginForm(
                      onSubmittedEmailAndPassword: (email, password) async =>
                          await context
                              .read<LoginCubit>()
                              .loginWithEmailAndPassword(
                                email: email,
                                password: password,
                              ),
                    ),
                    gapH32,
                    const Text(
                      'Or Continue With',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    gapH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FOutlinedIconButton(
                          label: 'Facebook',
                          iconPath: Assets.icons.facebookIcon.path,
                          onPressed: () async => await context
                              .read<LoginCubit>()
                              .loginWithFacebook(),
                        ),
                        gapW32,
                        FOutlinedIconButton(
                          label: 'Google',
                          iconPath: Assets.icons.googleIcon.path,
                          onPressed: () async => await context
                              .read<LoginCubit>()
                              .loginWithGoogle(),
                        ),
                      ],
                    ),
                    gapH16,
                    // TODO: Implement forgot password
                    FTextButton(
                      text: 'Forgot Your Password ?',
                      onPressed: () {},
                    ),

                    gapH16,
                    FTextButton(
                        text: 'Or create new account',
                        onPressed: () => FCoordinator.showSignUpScreen()),
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
