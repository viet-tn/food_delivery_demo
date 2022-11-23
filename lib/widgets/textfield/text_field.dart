import 'package:flutter/material.dart';

import '../../utils/ui/drop_shadow.dart';

class FTextField extends StatelessWidget {
  const FTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.iconPath,
    this.textStyle = const TextStyle(fontSize: 16.0),
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.controller,
    this.decoration,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final String? iconPath;
  final TextStyle textStyle;
  final TextInputType inputType;
  final bool obscureText;
  final bool enabled;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      child: TextFormField(
        onFieldSubmitted: onSubmitted,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        initialValue: initialValue,
        keyboardType: inputType,
        style: textStyle,
        decoration: decoration ??
            InputDecoration(
              enabled: enabled,
              labelText: labelText,
              hintText: hintText,
              prefixIcon: iconPath != null
                  ? Image.asset(
                      iconPath!,
                    )
                  : null,
            ),
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
