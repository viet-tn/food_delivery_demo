import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../widgets/rating_section.dart';

class FoodRating extends StatelessWidget {
  const FoodRating({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingSection(paths: [
      Assets.icons.star.path,
      Assets.icons.shoppingBag.path,
    ], texts: const [
      '4.8 Rating',
      '2000+ Order',
    ]);
  }
}
