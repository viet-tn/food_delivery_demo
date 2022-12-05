import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../modules/login/cubit/login_cubit.dart';
import '../../../widgets/buttons/gradient_button.dart';
import '../../../widgets/buttons/text_button.dart';
import '../../../widgets/textfield/text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    this.onSubmittedEmailAndPassword,
  });

  final void Function(String email, String password)?
      onSubmittedEmailAndPassword;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.email.value != current.email.value ||
          previous.password.value != current.password.value,
      builder: (_, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              FTextField(
                labelText: 'Email',
                inputType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<LoginCubit>().onChangeEmail(value),
                validator: (value) =>
                    state.email.valid ? null : state.email.error!.toErrorText(),
              ),
              gapH16,
              FTextField(
                // controller: _passwordController,
                labelText: 'Password',
                inputType: TextInputType.text,
                obscureText: true,
                onChanged: (value) =>
                    context.read<LoginCubit>().onChangePaswword(value),
                validator: (value) => state.password.valid
                    ? null
                    : state.password.error!.toErrorText(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FTextButton(
                  text: 'Forgot Password?',
                  onPressed: () {
                    FCoordinator.pushNamed(Routes.forgotPassword.name);
                  },
                ),
              ),
              GradientButton(
                width: double.infinity,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmittedEmailAndPassword
                        ?.call(state.email.value, state.password.value);
                  }
                },
                child: Text(
                  'Log In',
                  style: FTextStyles.button.copyWith(fontSize: 16.0),
                ),
              ),
              gapH12,
            ],
          ),
        );
      },
    );
  }
}
