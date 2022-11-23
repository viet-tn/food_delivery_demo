import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    this.gradient = FColors.linearGradient,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
