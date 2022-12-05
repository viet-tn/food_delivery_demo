import 'package:flutter/material.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/colors.dart';
import '../../constants/ui/ui_parameters.dart';

class FBackButton extends StatelessWidget {
  const FBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
        color: FColors.backButtonBgColor.withOpacity(.3),
        borderRadius: Ui.borderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed ?? FCoordinator.onBack,
          radius: 30.0,
          borderRadius: Ui.borderRadius,
          splashColor: FColors.pastelOrange,
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xFFF56E1B),
            ),
          ),
        ),
      ),
    );
  }
}
