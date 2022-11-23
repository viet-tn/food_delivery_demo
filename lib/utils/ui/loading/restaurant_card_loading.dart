import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/ui_parameters.dart';

class RestaurantCardLoading extends StatelessWidget {
  const RestaurantCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 110.0,
            width: 110.0,
            decoration: const BoxDecoration(
              borderRadius: Ui.borderRadius,
              color: FColors.loading,
            ),
          ),
          const SizedBox(),
          Container(
            height: 16.0,
            width: 100.0,
            color: FColors.loading,
          ),
          Container(
            height: 12.0,
            width: 80.0,
            color: FColors.loading,
          ),
        ],
      ),
    );
  }
}
