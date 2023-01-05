import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../modules/chat/widgets/loading_indicator.dart';
import '../../../widgets/buttons/gradient_button.dart';
import '../../../widgets/textfield/text_field.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
    this.isLoading = false,
    this.onEmailChanged,
    this.onSubmit,
    this.validateEmail,
  });

  final bool isLoading;
  final void Function(String value)? onEmailChanged;
  final VoidCallback? onSubmit;
  final String? Function()? validateEmail;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: FTextField(
            labelText: 'Email address',
            inputType: TextInputType.emailAddress,
            controller: _controller,
            onChanged: widget.onEmailChanged,
            validator: (_) {
              return widget.validateEmail?.call();
            },
          ),
        ),
        gapH20,
        GradientButton(
          width: double.infinity,
          onPressed: widget.isLoading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSubmit?.call();
                  }
                },
          child: widget.isLoading
              ? const FLoadingIndicator()
              : const Text(
                  'Send Instructions',
                  style: FTextStyles.button,
                ),
        ),
      ],
    );
  }
}
