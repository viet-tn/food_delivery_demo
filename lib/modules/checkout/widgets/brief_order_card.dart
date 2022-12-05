import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/network_image.dart';

class BriefOrderCard extends StatelessWidget {
  const BriefOrderCard({
    super.key,
    required this.food,
    required this.quantity,
  });

  final FFood food;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: Ui.borderRadius,
          child: SizedBox.square(
            dimension: 70.0,
            child: FNetworkImage(
              food.img,
            ),
          ),
        ),
        gapW16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FTextStyles.heading5
                    .copyWith(color: FColors.metallicOrange),
              ),
              Text(
                food.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FTextStyles.label.copyWith(
                  color: const Color(0xFFF79D65),
                ),
              ),
              Text(
                '﹩${food.price}',
                style: FTextStyles.heading4.copyWith(
                  color: const Color(0xFFF56E1B),
                ),
              )
            ],
          ),
        ),
        gapW32,
        Text(
          '× $quantity',
          style: FTextStyles.heading5.copyWith(
            color: FColors.metallicOrange,
          ),
        )
      ],
    );
  }
}
