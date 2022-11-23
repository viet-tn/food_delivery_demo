import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../widgets/rating_section.dart';

class RestaurantRating extends StatelessWidget {
  const RestaurantRating({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingSection(paths: [
      Assets.icons.locationPinOutlined.path,
      Assets.icons.star.path,
    ], texts: const [
      '19 Km',
      '4.8 Rating',
    ]);
  }
}
