import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/ui_parameters.dart';

class DropShadow extends StatelessWidget {
  const DropShadow({
    super.key,
    this.borderRadius = Ui.borderRadius,
    this.elevation = 10.0,
    this.shadowColor = FColors.shadow,
    required this.child,
  });

  final BorderRadiusGeometry borderRadius;
  final double elevation;
  final Color shadowColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: borderRadius,
      elevation: elevation,
      shadowColor: shadowColor,
      child: child,
    );
  }
}
