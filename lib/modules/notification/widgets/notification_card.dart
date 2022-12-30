import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/ui.dart';
import '../../../repositories/notification/notification.dart';
import '../../../utils/ui/card.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
  });

  final FNotification notification;

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: () => context.pushNamed(Routes.orderDetails.name,
          params: {'orderId': notification.orderId}),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: FTextStyles.heading4.copyWith(color: FColors.green),
                ),
                gapH12,
                Text(
                  notification.body,
                  style: FTextStyles.body,
                ),
              ],
            ),
          ),
          gapW8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(notification.created),
                style: FTextStyles.label.copyWith(color: Colors.grey),
              ),
              gapH8,
              Text(
                DateFormat('hh:mm').format(notification.created),
                style: FTextStyles.label.copyWith(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
