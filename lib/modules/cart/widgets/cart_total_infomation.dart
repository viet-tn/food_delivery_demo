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
  });

  final int subTotal;
  final int deliveryCharge;
  final int discount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Ui.screenPaddingHorizontal,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.banner.priceInfo.path),
            fit: BoxFit.fitWidth,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 16.0,
        ),
        child: Column(
          children: [
            gapH8,
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
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 60.0,
                minWidth: double.infinity,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: Ui.borderRadius,
                  ),
                ),
                child: const GradientText(
                  'Place My Order',
                  style: FTextStyles.heading4,
                ),
              ),
            ),
            gapH8,
          ],
        ),
      ),
    );
  }
}
