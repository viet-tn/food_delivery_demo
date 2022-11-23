import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import 'restaurant_card_loading.dart';

class RestaurantListLoading extends StatelessWidget {
  const RestaurantListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    const itemNo = 4;
    return Shimmer(
      gradient: FColors.shimmerGradient,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            itemNo,
            (_) => SizedBox.fromSize(
              size: Sizes.restaurantCard,
              child: const RestaurantCardLoading(),
            ),
          ),
        ),
      ),
    );
  }
}
