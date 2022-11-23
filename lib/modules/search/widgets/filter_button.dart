import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../gen/assets.gen.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.onFilterPressed,
  });

  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: const BoxDecoration(
        borderRadius: Ui.borderRadius,
        color: FColors.pastelOrange,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: Ui.borderRadius,
          onTap: onFilterPressed,
          child: Image.asset(
            Assets.icons.filter.path,
          ),
        ),
      ),
    );
  }
}
