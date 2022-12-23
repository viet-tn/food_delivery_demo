import 'package:flutter/material.dart';

import '../../../constants/ui/ui_parameters.dart';

class VoucherCard extends StatelessWidget {
  const VoucherCard({
    super.key,
    required this.img,
    this.onVoucherSelected,
  });

  final String img;
  final VoidCallback? onVoucherSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onVoucherSelected,
        child: ClipRRect(
          borderRadius: Ui.borderRadius,
          child: Image.asset(img),
        ),
      ),
    );
  }
}
