import 'package:flutter/material.dart';

import '../../constants/ui/colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    this.onPresssed,
    this.gradient = FColors.linearGradient,
    this.borderRadius = 15.0,
    this.height = 57.0,
    this.width = 141.0,
    this.contentPadding = const EdgeInsets.all(6.0),
    required this.child,
  });

  final VoidCallback? onPresssed;
  final Gradient gradient;
  final Color splashColor = const Color.fromRGBO(31, 95, 77, 1);
  final double borderRadius;
  final double height;
  final double width;
  final EdgeInsets contentPadding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        // min sizes for Material buttons
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPresssed,
            borderRadius: BorderRadius.circular(borderRadius),
            splashColor: splashColor,
            child: Center(
              child: Padding(
                padding: contentPadding,
                child: FittedBox(
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
