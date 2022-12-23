import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import '../cubits/app/app_cubit.dart';
import '../order/model/order.dart';
import '../tracking/widgets/current_order_card.dart';
import 'cubit/home_cubit.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ListenError<HomeCubit>(
        child: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              FScaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: Ui.screenPadding,
                      child: HomeAppBar(
                        onSearchBarPressed: () =>
                            FCoordinator.goNamed(Routes.search.name),
                      ),
                    ),
                    gapH16,
                    const Expanded(
                      child: HomeBody(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  15.0,
                  0.0,
                  15.0,
                  Sizes.navBarGapH.height!,
                ),
                child: BlocBuilder<AppCubit, AppState>(
                  buildWhen: (previous, current) =>
                      previous.order != current.order ||
                      previous.restaurant != current.restaurant,
                  builder: (context, state) {
                    if (state.order == null ||
                        state.restaurant == null ||
                        state.order?.status != OrderStatus.processing) {
                      return const SizedBox();
                    }

                    return CurrentOrderCard(
                      chatId: state.order!.id!,
                      source: state.restaurant!.coordinate,
                      destination: state.order!.userPosition,
                      shipper: state.shipper!,
                      deliveryTime: state.deliveryTime,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
