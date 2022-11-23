import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../cubit/app_cubit.dart';
import 'cubit/cart_cubit.dart';
import 'widgets/cart_total_infomation.dart';
import 'widgets/order_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenError<AppCubit>(
      child: BlocProvider(
        create: (_) => GetIt.I<CartCubit>(),
        child: FScaffold(
          body: Column(
            children: [
              const Padding(
                padding: Ui.screenPadding,
                child: SizedBox(
                  height: 50.0,
                  child: Center(
                    child: Text(
                      'Order details',
                      style: FTextStyles.heading2,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: BlocBuilder<AppCubit, AppState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.cart != current.cart,
                  builder: (context, state) {
                    if (state.cart == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.cart!.items.isEmpty) {
                      return Center(
                        child: Text(
                          'Your cart is empty',
                          style:
                              FTextStyles.heading4.copyWith(color: Colors.grey),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          state.cart!.items.length,
                          (index) {
                            final food = state.cartFoodList[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 4.0, 15.0, 10.0),
                              child: OrderCard(
                                onTap: () => FCoordinator.pushNamed(
                                  Routes.food.name,
                                  extra: food,
                                ),
                                food: food,
                                quantity: state.cart!.items[food.id]!,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: BlocBuilder<CartCubit, CartState>(
                  buildWhen: (previous, current) =>
                      previous.subTotal != current.subTotal ||
                      previous.deliveryCharge != current.deliveryCharge ||
                      previous.discount != current.discount,
                  builder: (_, state) {
                    return state.cart.items.isEmpty
                        ? const SizedBox()
                        : CartTotalInformation(
                            subTotal: state.subTotal,
                            deliveryCharge: state.deliveryCharge,
                            discount: state.discount,
                          );
                  },
                ),
              ),
              Sizes.navBarGapH,
            ],
          ),
        ),
      ),
    );
  }
}
