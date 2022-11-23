import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/scaffold.dart';
import 'cubit/home_cubit.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider(
        create: (_) => GetIt.I<HomeCubit>(),
        child: ListenError<HomeCubit>(
          child: SafeArea(
            child: FScaffold(
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
          ),
        ),
      ),
    );
  }
}
