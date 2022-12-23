import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../utils/ui/dashed_line.dart';
import '../../../widgets/buttons/gradient_button.dart';

class VoucherSection extends StatelessWidget {
  const VoucherSection({
    super.key,
    required this.itemTotal,
    required this.discount,
    this.onVoucherButtonPressed,
  });

  final int itemTotal;
  final int discount;
  final VoidCallback? onVoucherButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 15.0,
            offset: Offset(0, -10),
            blurStyle: BlurStyle.outer,
            spreadRadius: -10.0,
            color: FColors.shadowColor,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            onPressed: () => FCoordinator.pushNamed(Routes.voucher.name),
            padding: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        CupertinoIcons.ticket,
                        size: 25.0,
                        color: FColors.green,
                      ),
                      gapW8,
                      Text(
                        'Voucher',
                        style: FTextStyles.heading5,
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text('Select voucher'),
                      gapW8,
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: Ui.screenPaddingHorizontal,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item total:',
                      style: FTextStyles.label.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '\$$itemTotal',
                      style: FTextStyles.label.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                gapH4,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount:',
                      style: FTextStyles.label.copyWith(color: Colors.grey),
                    ),
                    Text(
                      '\$$discount',
                      style: FTextStyles.label.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                gapH12,
                DashedLine(
                  height: .5,
                  color: Colors.grey[400],
                ),
                gapH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: FTextStyles.heading4,
                    ),
                    Text(
                      '\$${itemTotal - discount}',
                      style: FTextStyles.heading4,
                    ),
                  ],
                ),
                gapH12,
                GradientButton(
                  width: double.infinity,
                  onPressed: () => FCoordinator.goNamed(Routes.checkout.name),
                  child: Text(
                    'Check Out',
                    style: FTextStyles.button.copyWith(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                gapH12,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
