import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../gen/assets.gen.dart';

import '../../../constants/ui/sizes.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/helpers/iterable_helpers.dart';
import '../cubit/orders_cubit.dart';
import '../model/order.dart';
import 'order_card.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
    required this.orders,
  });

  final List<FOrder> orders;

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
                final firstFoodId = orders[index].cart.items.keys.first;
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: BlocBuilder<OrdersCubit, OrdersState>(
                    buildWhen: (previous, current) =>
                        previous.representativeFood.length !=
                            current.representativeFood.length &&
                        current.representativeFood
                            .any((element) => element.id == firstFoodId),
                    builder: (context, state) {
                      return OrderCard(
                        food: state.representativeFood.findFirstElement<FFood>(
                            (food) => food.id == firstFoodId),
                        order: orders[index],
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
