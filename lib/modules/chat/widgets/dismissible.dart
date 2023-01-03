import 'package:flutter/material.dart';

import '../../../constants/ui/ui.dart';
import '../../../utils/ui/card.dart';
import '../../../widgets/dialogs/dialog.dart';

class FDismissible extends StatelessWidget {
  const FDismissible({
    super.key,
    this.onTap,
    required this.onDismiss,
    required this.child,
  });

  final VoidCallback? onTap;
  final VoidCallback onDismiss;
  final Widget child;

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
            confirmDismiss: (_) => _confirmDismiss(context),
            onDismissed: (_) => onDismiss(),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            child: FCard(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 2.0,
              ),
              onTap: onTap,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool?> _confirmDismiss(BuildContext context) async {
  bool result = false;
  await showDialog(
    context: context,
    builder: (context) => FAlertDialog(
      title: 'Confirm Delete',
      onYesPressed: () {
        Navigator.pop(context);
        result = true;
      },
    ),
  );
  return result;
}
