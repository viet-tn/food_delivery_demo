import 'dart:math';

import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/ui/gradient_text.dart';

class CartTotalInformation extends StatelessWidget {
  const CartTotalInformation({
    super.key,
    required this.subTotal,
    required this.deliveryCharge,
    required this.discount,
    this.buttonLabel,
    this.onPressed,
  });

  final int subTotal;
  final int deliveryCharge;
  final int discount;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: Ui.borderRadius,
        image: DecorationImage(
          image: AssetImage(Assets.images.banner.priceInfo.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sub-Total',
                style: FTextStyles.heading5.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${subTotal.toInt()} \$',
                style: FTextStyles.heading5.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Charge',
                style: FTextStyles.heading5.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${deliveryCharge.toInt()} \$',
                style: FTextStyles.heading5.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Discount',
                style: FTextStyles.heading5.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${discount.toInt()} \$',
                style: FTextStyles.heading5.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          gapH12,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: FTextStyles.heading3.copyWith(
                  color: Colors.white,
                ),
              ),
              Text(
                '${max(0, (subTotal + deliveryCharge - discount).toInt())} \$',
                style: FTextStyles.heading3.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          gapH8,
          SizedBox.fromSize(
            size: const Size.fromHeight(60.0),
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: Ui.borderRadius,
                ),
              ),
              child: GradientText(
                buttonLabel ?? 'Check Out',
                style: FTextStyles.heading4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
