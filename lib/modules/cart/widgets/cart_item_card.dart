import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../chat/widgets/dismissible.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/cart/item_model.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/network_image.dart';
import '../cubit/cart_cubit.dart';
import 'item_quantity_selector.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    this.onTap,
    required this.food,
    required this.quantity,
  });

  final VoidCallback? onTap;
  final FFood food;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return FDismissible(
      onTap: onTap,
      onDismiss: () => context.read<CartCubit>().onDeleteItem(food.id),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 80.0,
            child: ClipRRect(
              borderRadius: Ui.borderRadius,
              child: FNetworkImage(food.img),
            ),
          ),
          gapW12,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.heading5,
                ),
                Text(
                  food.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.label.copyWith(color: Colors.grey),
                ),
                gapH4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${food.price.toInt()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: FTextStyles.heading4.copyWith(
                        color: FColors.green,
                      ),
                    ),
                    ItemQuantitySelector(
                      onQuantityChanged: (quantity) =>
                          context.read<CartCubit>().onQuantityChanged(
                                Item(
                                  foodId: food.id,
                                  quantity: quantity,
                                ),
                              ),
                      onDeleteItem: () =>
                          context.read<CartCubit>().onDeleteItem(food.id),
                      quantity: quantity,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
