import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';

class BriefFoodCard extends StatelessWidget {
  const BriefFoodCard({
    super.key,
    required this.food,
    this.onPressed,
  });

  final FFood food;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox.square(
            dimension: 90.0,
            child: ClipRRect(
              borderRadius: Ui.borderRadius,
              child: FNetworkImage(food.img),
            ),
          ),
          const Spacer(),
          Text(
            food.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: FTextStyles.heading5,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Text(
            '\$${food.price.toInt()}',
            style: FTextStyles.label.copyWith(color: Colors.grey),
          ),
          gapH4,
        ],
      ),
    );
  }
}
