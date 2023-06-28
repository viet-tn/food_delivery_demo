import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../widgets/textfield/text_field.dart';
import '../../login/models/password_input.dart';
import '../../sign_up/models/sign_up_password_input.dart';

class ChangePasswordSection extends StatefulWidget {
  const ChangePasswordSection({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  State<ChangePasswordSection> createState() => _ChangePasswordSectionState();
}

class _ChangePasswordSectionState extends State<ChangePasswordSection> {
  PasswordInput newPassword = const PasswordInput.pure();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.only(top: 15.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: FColors.lightGreen,
            ),
            borderRadius: Ui.borderRadius,
          ),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                gapH12,
                FTextField(
                  controller: widget.currentPasswordController,
                  obscureText: true,
                  labelText: 'Current password',
                  textStyle: FTextStyles.body.copyWith(fontSize: 18.0),
                  validator: (_) {
                    if (widget.currentPasswordController.text.isEmpty) {
                      return 'Type your current password!';
                    }
                    return null;
                  },
                ),
                gapH12,
                FTextField(
                  controller: widget.newPasswordController,
                  obscureText: true,
                  labelText: 'New password',
                  textStyle: FTextStyles.body.copyWith(fontSize: 18.0),
                  validator: (_) {
                    SignUpPasswordInput password =
                        const SignUpPasswordInput.pure();
                    if (widget.newPasswordController.text != '') {
                      password = SignUpPasswordInput.dirty(
                          widget.newPasswordController.text);
                    }
                    if (!password.valid) {
                      return password.error!.toErrorText();
                    }
                    return null;
                  },
                ),
                gapH12,
                FTextField(
                  controller: widget.confirmPasswordController,
                  obscureText: true,
                  labelText: 'Confirm password',
                  textStyle: FTextStyles.body.copyWith(fontSize: 18.0),
                  validator: (_) {
                    if (widget.newPasswordController.text !=
                        widget.confirmPasswordController.text) {
                      return 'Password doesn\'t match!';
                    }
                    return null;
                  },
                ),
                gapH20,
              ],
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 2.0,
          child: ColoredBox(
            color: Colors.white,
            child: Text(
              'Change Password',
              style: FTextStyles.heading4.copyWith(color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
