import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/helpers/text_helpers.dart';
import '../../../widgets/rating_section.dart';

class RestaurantRating extends StatelessWidget {
  const RestaurantRating({
    super.key,
    required this.meters,
  });

  final int meters;

  @override
  Widget build(BuildContext context) {
    return RatingSection(paths: [
      Assets.icons.locationPinOutlined.path,
      Assets.icons.star.path,
    ], texts: [
      StringExtension.toKm(meters),
      '0 Rating',
    ]);
  }
}
