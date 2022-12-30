import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/ui/sizes.dart';
import '../../../gen/assets.gen.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../cubit/orders_cubit.dart';
import '../model/order.dart';
import 'order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
    required this.orders,
    required this.restaurants,
  });

  final List<FOrder> orders;
  final List<FRestaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.navBarGapH.height!),
      child: orders.isEmpty
          ? Center(
              child: SizedBox.square(
                dimension: 300.0,
                child: SvgPicture.asset(
                  Assets.images.illustrations.empty,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: BlocBuilder<OrdersCubit, OrdersState>(
                    buildWhen: (previous, current) =>
                        previous.runningOrders.length !=
                            current.runningOrders.length ||
                        previous.historyOrders.length !=
                            current.historyOrders.length,
                    builder: (context, state) {
                      final order = orders[index];
                      final restaurant = restaurants.firstWhere((restaurant) =>
                          order.cart.restaurantId == restaurant.id);
                      return OrderCard(
                        order: order,
                        restaurant: restaurant,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
