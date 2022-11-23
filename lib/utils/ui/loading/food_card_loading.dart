import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/ui_parameters.dart';

class FoodCardLoading extends StatelessWidget {
  const FoodCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100.0,
          width: 100.0,
          decoration: const BoxDecoration(
            borderRadius: Ui.borderRadius,
            color: FColors.loading,
          ),
        ),
        gapW12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16.0,
                color: FColors.loading,
              ),
              gapH16,
              Container(
                height: 12.0,
                color: FColors.loading,
              ),
              gapH12,
              Container(
                height: 12.0,
                width: 100.0,
                color: FColors.loading,
              ),
            ],
          ),
        ),
        gapW32,
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            borderRadius: Ui.borderRadius,
            color: FColors.loading,
          ),
        ),
      ],
    );
  }
}
