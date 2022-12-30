import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../modules/sign_up/cubit/sign_up_cubit.dart';
import '../../../modules/sign_up/models/sign_up_password_input.dart';
import '../../../widgets/buttons/gradient_button.dart';
import '../../../widgets/textfield/text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    this.onSubmittedCreateAccount,
  });

  final void Function(String email, String password)? onSubmittedCreateAccount;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.email.value != current.email.value ||
          previous.password.value != current.password.value,
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              FTextField(
                labelText: 'Email',
                prefixIcon: Image.asset(Assets.icons.message.path),
                inputType: TextInputType.emailAddress,
                onChanged: (value) =>
                    context.read<SignUpCubit>().onChangeEmail(value),
                validator: (value) =>
                    state.email.valid ? null : state.email.error!.toErrorText(),
              ),
              gapH12,
              FTextField(
                labelText: 'Password',
                prefixIcon: Image.asset(Assets.icons.lock.path),
                obscureText: true,
                onChanged: (value) =>
                    context.read<SignUpCubit>().onChangePassword(value),
                validator: (value) => state.password.valid
                    ? null
                    : state.password.error!.toErrorText(),
              ),
              gapH12,
              FTextField(
                labelText: 'Re-enter Password',
                prefixIcon: Image.asset(Assets.icons.lock.path),
                obscureText: true,
                validator: (value) => value == state.password.value
                    ? null
                    : SignUpPasswordValidationError.notMatch.toErrorText(),
              ),
              // gapH16,
              // FRadioListTile(
              //   onTap: (value) {},
              //   value: true,
              //   text: 'Keep Me Signed In',
              // ),
              // gapH16,
              // FRadioListTile(
              //   onTap: (value) {},
              //   value: false,
              //   text: 'Email Me About Special Pricing',
              // ),
              gapH32,
              GradientButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmittedCreateAccount
                        ?.call(state.email.value, state.password.value);
                  }
                },
                child: const Text(
                  'Create Account',
                  style: FTextStyles.button,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
