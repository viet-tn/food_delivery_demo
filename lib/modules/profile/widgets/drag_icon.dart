import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/ui_parameters.dart';

class DragIcon extends StatelessWidget {
  const DragIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: 60,
      decoration: const BoxDecoration(
        borderRadius: Ui.borderRadius,
        color: FColors.pastelOrange,
      ),
    );
  }
}
