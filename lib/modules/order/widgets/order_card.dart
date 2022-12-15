import 'package:flutter/material.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/helpers/text_helpers.dart';
import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';
import '../../../widgets/buttons/gradient_button.dart';
import '../../../widgets/chips/category_chip.dart';
import '../model/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.food,
  });

  final FOrder order;
  final FFood? food;

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryChip(
                padding: const EdgeInsets.all(1.0),
                text: order.status.name.capitalize(),
                textStyle: FTextStyles.heading6.copyWith(
                  color: FColors.green,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    SizedBox.square(
                      dimension: 15.0,
                      child: Image.asset(Assets.icons.edit.path),
                    ),
                    gapW8,
                    Text(
                      'Rate food',
                      style: FTextStyles.button.copyWith(color: FColors.green),
                    ),
                  ],
                ),
              )
            ],
          ),
          const Divider(height: 2.0),
          gapH4,
          Row(
            children: [
              SizedBox.square(
                dimension: 70.0,
                child: food == null
                    ? const CircularProgressIndicator()
                    : FNetworkImage(food!.img),
              ),
              gapW20,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food?.name ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: FTextStyles.heading5,
                    ),
                    gapH8,
                    Text(
                      'Quantity ${order.cart.items.values.fold(0, (previousValue, element) => previousValue + element)} | \$${order.paid}',
                      style: FTextStyles.label.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
          gapH12,
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45.0,
                  child: OutlinedButton(
                    onPressed: () {
                      FCoordinator.goNamed(
                        Routes.orderDetails.name,
                        extra: order,
                      );
                    },
                    child: Text(
                      'View Details',
                      style: FTextStyles.button.copyWith(color: FColors.green),
                    ),
                  ),
                ),
              ),
              gapW8,
              Expanded(
                child: SizedBox(
                  height: 45.0,
                  child: GradientButton(
                    onPressed: () {},
                    child: const Text(
                      'Reorder',
                      style: FTextStyles.button,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
