import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/app_bar.dart';
import '../cubit/app_cubit.dart';
import 'cubit/cart_cubit.dart';
import 'widgets/cart_total_infomation.dart';
import 'widgets/order_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FCoordinator.goNamed(Routes.home.name);
        return false;
      },
      child: ListenError<AppCubit>(
        child: FScaffold(
          body: Column(
            children: [
              const Padding(
                padding: Ui.screenPaddingHorizontal,
                child: FAppBar(title: 'Cart'),
              ),
              Expanded(
                flex: 3,
                child: BlocBuilder<CartCubit, CartState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.cart != current.cart,
                  builder: (context, state) {
                    if (state.cart.items.isEmpty) {
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
                          state.cart.items.length,
                          (index) {
                            final food = state.foods[index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  15.0, 4.0, 15.0, 10.0),
                              child: OrderCard(
                                onTap: () => FCoordinator.pushNamed(
                                  Routes.food.name,
                                  extra: food,
                                ),
                                food: food,
                                quantity: state.cart.items[food.id]!,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) => previous.cart != current.cart,
                builder: (_, state) {
                  return state.cart.items.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: Ui.screenPaddingHorizontal,
                          child: CartTotalInformation(
                            onPressed: () {
                              FCoordinator.goNamed(Routes.checkout.name);
                            },
                            subTotal: state.subTotal,
                            deliveryCharge: state.deliveryCharge,
                            discount: state.discount,
                          ),
                        );
                },
              ),
              Sizes.navBarGapH,
            ],
          ),
        ),
      ),
    );
  }
}
