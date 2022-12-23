import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_constants.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/scaffold.dart';
import '../../widgets/app_bar.dart';
import '../cart/cubit/cart_cubit.dart';
import 'widgets/voucher_card.dart';

class VoucherScreen extends StatelessWidget {
  const VoucherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      body: Column(
        children: [
          const Padding(
            padding: Ui.screenPadding,
            child: FAppBar(title: 'Voucher'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: Ui.screenPadding,
              child: Column(
                children: [
                  gapH32,
                  ...List.generate(
                    vouchers.length,
                    (index) => BlocBuilder<CartCubit, CartState>(
                      buildWhen: (_, __) => false,
                      builder: (context, state) {
                        return VoucherCard(
                          img: vouchers.elementAt(index),
                          onVoucherSelected: () {
                            context.read<CartCubit>().onVoucherChanged(
                                (state.subTotal * .1).floor());
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
