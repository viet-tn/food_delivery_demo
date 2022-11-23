import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/cart/item_model.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';
import '../../../widgets/dialogs/alert_dialog.dart';
import '../cubit/cart_cubit.dart';
import 'item_quantity_selector.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
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
    return SizedBox(
      height: Sizes.orderCardHeight,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20.0),
            decoration: const BoxDecoration(
              borderRadius: Ui.borderRadius,
              color: FColors.darkTangerine,
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          Dismissible(
            confirmDismiss: (_) => confirmDismiss(context),
            onDismissed: (_) => context.read<CartCubit>().onDeleteItem(food.id),
            key: ValueKey(food.id),
            direction: DismissDirection.endToStart,
            child: FCard(
              onTap: onTap,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyles.heading4,
                        ),
                        Text(
                          food.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyles.body.copyWith(color: Colors.grey),
                        ),
                        Text(
                          '\$ ${food.price.toInt()}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FTextStyles.heading3.copyWith(
                            color: FColors.green,
                          ),
                        ),
                      ],
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
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> confirmDismiss(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => const FAlertDialog(title: 'Confirm Delete'),
    );
  }
}
