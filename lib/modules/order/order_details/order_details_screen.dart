import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../utils/helpers/text_helpers.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/app_bar.dart';
import '../../../widgets/chips/category_chip.dart';
import '../../cubits/app/app_cubit.dart';
import '../cubit/orders_cubit.dart';
import '../model/order.dart';
import 'cubit/order_details_cubit.dart';
import 'widgets/order_details_card.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  final FOrder order;

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final _cubit = GetIt.I<OrderDetailsCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.init(widget.order);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: FScaffold(
        body: Column(
          children: [
            const Padding(
              padding: Ui.screenPadding,
              child: FAppBar(title: 'Order Details'),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: Ui.screenPaddingHorizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gapH20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.list_alt),
                        gapW12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order No. ${widget.order.id.hashCode}',
                                    style: FTextStyles.heading5,
                                  ),
                                  Text(
                                    DateFormat('dd-MM-y')
                                        .format(widget.order.created),
                                    style: FTextStyles.body
                                        .copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Status: ',
                                    style: FTextStyles.body,
                                  ),
                                  CategoryChip(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    text: widget.order.status.name.capitalize(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    gapH20,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.pin_drop_outlined),
                        gapW12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Address',
                                style: FTextStyles.heading5,
                              ),
                              Text(widget.order.name),
                              Text(widget.order.phone),
                              Text(
                                widget.order.userPosition.address!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    gapH20,
                    BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status ||
                          previous.foods?.length != current.foods?.length,
                      builder: (context, state) {
                        if (state.status.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Column(
                          children: List.generate(
                            state.foods!.length,
                            (index) {
                              final food = state.foods![index];
                              return Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(top: 10.0),
                                child: OrderDetailsCard(
                                  quantity: widget.order.cart.items[food.id]!,
                                  food: food,
                                  status: widget.order.status,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    gapH64,
                    widget.order.status == OrderStatus.processing
                        ? SizedBox.fromSize(
                            size: const Size.fromHeight(50.0),
                            child: OutlinedButton(
                              onPressed: () =>
                                  context.read<OrdersCubit>().cancelOrder(
                                widget.order,
                                onCancelSucceeded: () {
                                  context.read<AppCubit>().onOrderCanceled();
                                  Navigator.pop(context);
                                },
                              ),
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red)),
                              child: Text(
                                'Cancel Order',
                                style: FTextStyles.button
                                    .copyWith(color: Colors.red),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
