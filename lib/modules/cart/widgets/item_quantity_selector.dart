import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../widgets/buttons/gradient_button.dart';

class ItemQuantitySelector extends StatelessWidget {
  const ItemQuantitySelector({
    super.key,
    required this.quantity,
    this.onQuantityChanged,
    this.onDeleteItem,
  });

  final int quantity;
  final void Function(int quantity)? onQuantityChanged;
  final VoidCallback? onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GradientButton(
          onPressed: () => quantity == 1
              ? onDeleteItem?.call()
              : onQuantityChanged?.call(quantity - 1),
          gradient: FColors.linearGradient.scale(.2),
          height: 30.0,
          width: 30.0,
          borderRadius: 8.0,
          contentPadding: EdgeInsets.zero,
          child: const Icon(
            Icons.remove,
            color: FColors.green,
          ),
        ),
        gapW16,
        Text(
          quantity.toString(),
          style: FTextStyles.heading5,
        ),
        gapW16,
        GradientButton(
          onPressed: () => onQuantityChanged?.call(quantity + 1),
          height: 30.0,
          width: 30.0,
          borderRadius: 8.0,
          contentPadding: EdgeInsets.zero,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
