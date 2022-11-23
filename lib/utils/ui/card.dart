import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/ui_parameters.dart';

class FCard extends StatelessWidget {
  const FCard({
    super.key,
    this.onTap,
    this.contentPadding = const EdgeInsets.all(12.0),
    this.borderRadius = Ui.borderRadius,
    required this.child,
  });

  final VoidCallback? onTap;
  final EdgeInsets contentPadding;
  final Widget child;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: FColors.shadow,
            blurRadius: 20.0,
            spreadRadius: -10,
            offset: Offset(5.0, 10.0),
          ),
        ],
        color: Colors.white,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: contentPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
