import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';

/// Prametes of Image storage provider [Imgix.com] to resize image for better
/// loading
/// https://docs.imgix.com/apis/rendering/size/fit
const _imgixPrameters = '?fit=scale&w=100&h=100';

class FoodCard extends StatelessWidget {
  const FoodCard({
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
      contentPadding: EdgeInsets.zero,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: Ui.borderRadius,
                child: FNetworkImage('${food.img}$_imgixPrameters'),
              ),
            ),
          ),
          gapW8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.heading5,
                ),
                gapH4,
                Text(
                  food.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.label.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          gapW12,
          Text(
            '\$${food.price.toInt()}',
            style: FTextStyles.heading3.copyWith(color: Colors.orangeAccent),
          ),
          gapW12,
        ],
      ),
    );
  }
}
