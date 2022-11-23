import 'package:flutter/material.dart';

class FForm extends StatelessWidget {
  const FForm({
    super.key,
    required this.children,
    this.constraints = const BoxConstraints(),
    this.formKey,
    this.onSubmit,
  });

  final List<Widget> children;
  final BoxConstraints constraints;
  final Key? formKey;
  final VoidCallback? onSubmit;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: constraints,
      child: Form(
        key: formKey,
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
