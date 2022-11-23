import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/ui/card.dart';

class VoucherCountSection extends StatelessWidget {
  const VoucherCountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: () {},
      child: Row(
        children: [
          SizedBox.square(
            dimension: 60.0,
            child: Image.asset(
              Assets.icons.voucherIcon.path,
              fit: BoxFit.contain,
            ),
          ),
          gapW20,
          const Text(
            'You have 3 vouchers',
            style: FTextStyles.heading4,
          ),
        ],
      ),
    );
  }
}
