import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/routes/coordinator.dart';
import '../../constants/ui/colors.dart';

import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/forms/login_form.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/loading_screen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/buttons/outlined_button.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoginWithEmail = false;
  final _buttonTextStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.user != current.user,
      listener: (context, state) {
        if (state.user.isNotEmpty) {
          FCoordinator.goNamed(Routes.home.name);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          setState(() {
            _isLoginWithEmail = false;
          });
          return false;
        },
        child: BlocBuilder<LoginCubit, LoginState>(
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
                        Image.asset(
                          Assets.images.splash.logo.path,
                          fit: BoxFit.cover,
                        ),
                        gapH32,
                        const Text(
                          'Login To Your Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        gapH12,
                        _isLoginWithEmail
                            ? LoginForm(
                                onSubmittedEmailAndPassword:
                                    (email, password) async => await context
                                        .read<LoginCubit>()
                                        .loginWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        ),
                              )
                            : LoginOption(
                                onEmailLoginPressed: () {
                                  setState(() {
                                    _isLoginWithEmail = true;
                                  });
                                },
                              ),
                        gapH16,
                        const Text(
                          'Not a member?',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        gapH12,
                        FOutlinedButton(
                          minWidth: double.infinity,
                          color: FColors.vistaBlue,
                          label: 'Create your account',
                          style: _buttonTextStyle,
                          iconPath: Assets.icons.message.path,
                          onPressed: () {
                            FCoordinator.pushNamed(Routes.signUp.name);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LoginOption extends StatelessWidget {
  const LoginOption({
    super.key,
    this.onEmailLoginPressed,
  });

  final VoidCallback? onEmailLoginPressed;

  final _buttonTextStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        gapH12,
        FOutlinedButton(
          minWidth: double.infinity,
          label: 'Continue with Google',
          style: _buttonTextStyle,
          iconPath: Assets.icons.googleIcon.path,
          onPressed: () => context.read<LoginCubit>().loginWithGoogle(),
        ),
        gapH12,
        FOutlinedButton(
          minWidth: double.infinity,
          label: 'Continue with Facebook',
          style: _buttonTextStyle,
          iconPath: Assets.icons.facebookIcon.path,
          onPressed: () => context.read<LoginCubit>().loginWithFacebook(),
        ),
        gapH12,
        FOutlinedButton(
          minWidth: double.infinity,
          label: 'Continue with Email',
          style: _buttonTextStyle,
          iconPath: Assets.icons.message.path,
          onPressed: onEmailLoginPressed,
        ),
      ],
    );
  }
}
