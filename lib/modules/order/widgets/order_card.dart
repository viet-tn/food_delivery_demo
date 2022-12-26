import 'package:flutter/material.dart';
import '../../../config/routes/coordinator.dart';
import '../../../constants/constants.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../repositories/users/coordinate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';
import '../model/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.restaurant,
  });

  final FOrder order;
  final FRestaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: () => context.goNamed(Routes.orderDetails.name, extra: order),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 70.0,
            child: FNetworkImage(restaurant.url),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'Order ID: ',
                        style: FTextStyles.label,
                        children: [
                          TextSpan(
                            text: '#${order.id.hashCode}',
                            style: FTextStyles.label.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: order.status == OrderStatus.delivered
                            ? FColors.green.withAlpha(60)
                            : order.status == OrderStatus.cancelled
                                ? Colors.red.withAlpha(60)
                                : FColors.metallicOrange.withAlpha(60),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        order.status.toString(),
                        style: FTextStyles.chip.copyWith(
                          color: order.status == OrderStatus.delivered
                              ? FColors.green
                              : order.status == OrderStatus.cancelled
                                  ? Colors.red
                                  : FColors.metallicOrange,
                        ),
                      ),
                    ),
                  ],
                ),
                gapH12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('d MMM yyyy HH:mm').format(order.created),
                      style: FTextStyles.label.copyWith(color: Colors.grey),
                    ),
                    order.isRunning
                        ? SizedBox(
                            height: 30.0,
                            width: 100.0,
                            child: OutlinedButton(
                              onPressed: () => context.pushNamed(
                                Routes.orderTracking.name,
                                extra: <Coordinate>[
                                  restaurant.coordinate,
                                  order.userPosition,
                                ],
                              ),
                              child: FittedBox(
                                child: Text(
                                  'Track Order',
                                  style: FTextStyles.label.copyWith(
                                    color: FColors.green,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Text.rich(
                            TextSpan(
                              text: 'Item: ',
                              style: FTextStyles.body,
                              children: [
                                TextSpan(
                                  text: '${order.cart.items.length}',
                                  style: FTextStyles.label.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: FColors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
