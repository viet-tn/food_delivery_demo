import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../utils/helpers/text_helpers.dart';
import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    this.onPressed,
    required this.restaurant,
  });

  final FRestaurant restaurant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: onPressed,
      contentPadding: const EdgeInsets.all(4.0),
      child: SizedBox.fromSize(
        size: Sizes.restaurantCard,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FNetworkImage(restaurant.url),
              ),
            ),
            Text(
              restaurant.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FTextStyles.heading4,
            ),
            gapH4,
            restaurant.duration == null
                ? const SizedBox()
                : Text(
                    StringExtension.toTime(restaurant.duration!),
                    style: FTextStyles.label.copyWith(
                      color: Colors.grey,
                    ),
                  ),
            gapH32,
          ],
        ),
      ),
    );
  }
}
