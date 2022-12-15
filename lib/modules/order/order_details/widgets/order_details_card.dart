import 'package:flutter/material.dart';

import '../../../../constants/ui/colors.dart';
import '../../../../constants/ui/sizes.dart';
import '../../../../constants/ui/text_style.dart';
import '../../../../constants/ui/ui_parameters.dart';
import '../../../../repositories/food/food_model.dart';
import '../../../../utils/ui/network_image.dart';
import '../../model/order.dart';

class OrderDetailsCard extends StatelessWidget {
  const OrderDetailsCard({
    super.key,
    required this.quantity,
    required this.food,
    required this.status,
  });

  final int quantity;
  final FFood food;
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.orderDetailsCardHeight,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: Ui.borderRadius,
            child: SizedBox.square(
              dimension: 100.0,
              child: FNetworkImage(food.img),
            ),
          ),
          gapW20,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  style: FTextStyles.label.copyWith(
                    color: Colors.grey,
                    height: 1.1,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '×$quantity \$${food.price}',
                      style: FTextStyles.heading5.copyWith(fontSize: 14.0),
                    ),
                    status != OrderStatus.delivered
                        ? const SizedBox()
                        : SizedBox(
                            height: 32.0,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                'Write a review',
                                style: FTextStyles.button
                                    .copyWith(color: FColors.green),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
