import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../repositories/cart/cart_model.dart';
import '../../../repositories/food/food_model.dart';
import 'brief_order_card.dart';
import 'editable_section_bar.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({
    super.key,
    required this.cart,
    required this.foods,
  });

  final FCart cart;
  final List<FFood> foods;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditableSectionBar(
          onEditPressed: () {
            Navigator.pop(context);
          },
          title: 'Order Summary',
        ),
        gapH8,
        ...foods.map(
          (food) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: BriefOrderCard(
              food: food,
              quantity: cart.items[food.id]!,
            ),
          ),
        ),
        Sizes.navBarGapH,
      ],
    );
  }
}
