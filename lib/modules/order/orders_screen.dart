import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/app_bar.dart';
import 'cubit/orders_cubit.dart';
import 'widgets/order_list.dart';
import 'widgets/order_tab.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late final _pageController = PageController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // TODO: Remove when [ShellRoute] preseve state
    context.read<OrdersCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FCoordinator.showHomeScreen();
        return false;
      },
      child: FScaffold(
        body: Padding(
          padding: Ui.screenPadding,
          child: Column(
            children: [
              const FAppBar(title: 'My Orders'),
              BlocSelector<OrdersCubit, OrdersState, int>(
                selector: (state) => state.currentPage,
                builder: (context, state) {
                  return OrderTab(
                    currentIndex: state,
                    items: const <String>['Running', 'History'],
                    onPressed: (index) => context
                        .read<OrdersCubit>()
                        .onPageChanged(index, _pageController),
                  );
                },
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    timer?.cancel();
                    timer = Timer(const Duration(milliseconds: 100),
                        () => context.read<OrdersCubit>().onPageChanged(index));
                  },
                  children: [
                    BlocBuilder<OrdersCubit, OrdersState>(
                      buildWhen: (previous, current) =>
                          previous.runningOrders != current.runningOrders,
                      builder: (context, state) {
                        return OrdersList(
                          orders: state.runningOrders,
                          restaurants: state.restaurants,
                        );
                      },
                    ),
                    BlocBuilder<OrdersCubit, OrdersState>(
                      buildWhen: (previous, current) =>
                          previous.historyOrders != current.historyOrders,
                      builder: (context, state) {
                        return OrdersList(
                          orders: state.historyOrders,
                          restaurants: state.restaurants,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
