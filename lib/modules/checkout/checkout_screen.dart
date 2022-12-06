import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../base/state.dart';
import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../repositories/domain_manager.dart';
import '../../repositories/users/user_model.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/loading_screen.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/app_bar.dart';
import '../cart/cubit/cart_cubit.dart';
import '../cart/widgets/cart_total_infomation.dart';
import '../cubits/app/app_cubit.dart';
import 'cubit/payment_cubit.dart';
import 'widgets/order_summary_section.dart';
import 'widgets/shipping_address_section.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<PaymentCubit>(),
      child: BlocSelector<PaymentCubit, PaymentState, ScreenStatus>(
        selector: (state) {
          return state.status;
        },
        builder: (context, state) {
          return BlocListener<PaymentCubit, PaymentState>(
            listenWhen: (_, current) => current.isSuccess == true,
            listener: (context, state) {
              FCoordinator.goNamed(Routes.home.name);
              DomainManager().cartRepository.clear();
              context.read<CartCubit>().clear();
            },
            child: ListenError<PaymentCubit>(
              child: LoadingScreen(
                isLoading: state.isLoading,
                child: FScaffold(
                  body: Padding(
                    padding: Ui.screenPadding,
                    child: Column(
                      children: [
                        const FAppBar(title: 'Check Out'),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                BlocSelector<AppCubit, AppState, FUser>(
                                  selector: (state) {
                                    return state.user!;
                                  },
                                  builder: (context, state) {
                                    return ShippingAdressSection(
                                      name:
                                          '${state.firstName} ${state.lastName}',
                                      phone: state.phone!,
                                      address: state.coordinates.first.address!,
                                    );
                                  },
                                ),
                                gapH20,
                                BlocBuilder<CartCubit, CartState>(
                                  buildWhen: (previous, current) =>
                                      previous.cart != current.cart,
                                  builder: (context, state) {
                                    return OrderSummarySection(
                                      cart: state.cart,
                                      foods: state.foods,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Sizes.orderInforGapH,
                      ],
                    ),
                  ),
                  centerBottomButton: BlocBuilder<CartCubit, CartState>(
                    buildWhen: (previous, current) =>
                        previous.cart != current.cart,
                    builder: (context, state) {
                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
                        child: CartTotalInformation(
                          onPressed: () {
                            context.read<PaymentCubit>().onCheckoutPressed(
                                state.total * 100); // convert dolar to cent
                          },
                          subTotal: state.subTotal,
                          deliveryCharge: state.deliveryCharge,
                          discount: state.discount,
                          buttonLabel: 'Place My Order',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
