import 'package:flutter/material.dart';

import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/drop_shadow.dart';

class FTextField extends StatefulWidget {
  const FTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.initialValue,
    this.textStyle = const TextStyle(fontSize: 16.0),
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.enabled = true,
    this.controller,
    this.decoration,
    this.contentPadding,
    this.prefixIcon,
    this.borderRadius = Ui.borderRadius,
    this.validator,
    this.onChanged,
    this.onSubmitted,
  });

  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextStyle textStyle;
  final TextInputType inputType;
  final bool obscureText;
  final bool enabled;
  final TextEditingController? controller;
  final InputDecoration? decoration;
  final EdgeInsets? contentPadding;
  final Widget? prefixIcon;
  final BorderRadiusGeometry borderRadius;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  State<FTextField> createState() => _FTextFieldState();
}

class _FTextFieldState extends State<FTextField> {
  late bool? hasText = widget.controller?.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_controllerListener);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_controllerListener);
    super.dispose();
  }

  void _controllerListener() {
    setState(() {
      hasText = widget.controller?.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      borderRadius: widget.borderRadius,
      child: TextFormField(
        autocorrect: false,
        onFieldSubmitted: widget.onSubmitted,
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller,
        initialValue: widget.initialValue,
        keyboardType: widget.inputType,
        style: widget.textStyle,
        decoration: widget.decoration ??
            InputDecoration(
              contentPadding: widget.contentPadding,
              enabled: widget.enabled,
              labelText: widget.labelText,
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              suffix: SizedBox.square(
                dimension: 30.0,
                child: hasText == true
                    ? IconButton(
                        onPressed: () {
                          widget.controller?.clear();
                        },
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.clear),
                      )
                    : null,
              ),
            ),
        obscureText: widget.obscureText,
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}
