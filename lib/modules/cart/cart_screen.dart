import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/voucher_section.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../cubits/app/app_cubit.dart';
import 'cubit/cart_cubit.dart';
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
                      previous.cart.items.length != current.cart.items.length,
                  builder: (context, state) {
                    if (state.cart.items.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox.square(
                            dimension: 300.0,
                            child: SvgPicture.asset(
                                Assets.images.illustrations.cart),
                          ),
                          Text(
                            'Your cart is empty',
                            style: FTextStyles.heading5
                                .copyWith(color: Colors.grey),
                          ),
                          gapH20,
                          GradientButton(
                            onPressed: () =>
                                FCoordinator.goNamed(Routes.search.name),
                            child: const Text(
                              'Explore food now',
                              style: FTextStyles.button,
                            ),
                          ),
                        ],
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
                                15.0,
                                4.0,
                                15.0,
                                6.0,
                              ),
                              child: BlocBuilder<CartCubit, CartState>(
                                buildWhen: (previous, current) =>
                                    previous.cart.items[food.id] !=
                                    current.cart.items[food.id],
                                builder: (context, state) {
                                  return OrderCard(
                                    onTap: () => FCoordinator.pushNamed(
                                      Routes.food.name,
                                      extra: food,
                                    ),
                                    food: food,
                                    quantity: state.cart.items[food.id]!,
                                  );
                                },
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
                buildWhen: (previous, current) =>
                    previous.cart != current.cart ||
                    previous.discount != current.discount,
                builder: (context, state) {
                  return state.subTotal == 0
                      ? const SizedBox()
                      : VoucherSection(
                          itemTotal: state.subTotal,
                          discount: state.discount,
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
