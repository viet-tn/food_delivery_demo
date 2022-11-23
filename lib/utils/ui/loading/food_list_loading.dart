import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/ui/colors.dart';
import 'food_card_loading.dart';

class FoodListLoading extends StatelessWidget {
  const FoodListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const itemCount = 10;
    return Shimmer(
      gradient: FColors.shimmerGradient,
      child: Column(
        children: List.generate(
          itemCount,
          (_) => const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: FoodCardLoading(),
          ),
        ),
      ),
    );
  }
}
