import 'package:flutter/material.dart';

import '../../../repositories/users/user_model.dart';
import 'payment_button.dart';

class PaymentSelector extends StatefulWidget {
  const PaymentSelector({
    super.key,
    required this.onPaymentSelected,
  });

  final void Function(PaymentMethod method) onPaymentSelected;

  @override
  State<PaymentSelector> createState() => _PaymentSelectorState();
}

class _PaymentSelectorState extends State<PaymentSelector> {
  final _methods = PaymentMethod.values;
  int isSelected = 0;

  @override
  void initState() {
    widget.onPaymentSelected(_methods[isSelected]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        _methods.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: PaymentButton(
            logoPath: _methods[index].path,
            onPressed: () {
              widget.onPaymentSelected(_methods[index]);
              setState(() => isSelected = index);
            },
            isChoose: index == isSelected,
          ),
        ),
      ),
    );
  }
}
