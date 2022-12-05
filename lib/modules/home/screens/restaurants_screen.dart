import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../utils/ui/listen_error.dart';
import '../../../utils/ui/loading/restaurant_card_loading.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/app_bar.dart';
import '../widgets/restaurant_card.dart';
import 'cubit/view_more_cubit.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  late final _scrollController = ScrollController();
  late final _cubit = GetIt.I<ViewMoreCubit>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _cubit.fetchFistNearestRestaurantBatch();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 400.0) {
      return;
    }
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 200),
      () {
        _cubit.fetchNextNearestRestaurantBatch();
        log('fetchNextNearestRestaurantBatch');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenError<ViewMoreCubit>(
      bloc: _cubit,
      child: FScaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: FAppBar(title: 'Nearest Restaurants'),
            ),
            Flexible(
              child: BlocBuilder<ViewMoreCubit, ViewMoreState>(
                bloc: _cubit,
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.restaurants?.length != current.restaurants?.length,
                builder: (context, state) {
                  if (state.restaurants == null) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (_, __) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: RestaurantCardLoading(),
                      ),
                    );
                  }

                  if (state.restaurants!.isEmpty) {
                    return const Text('Empty');
                  }

                  return GridView.builder(
                    controller: _scrollController,
                    itemCount: state.restaurants!.length,
                    padding: Ui.screenPadding,
                    cacheExtent: 500.0,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                    itemBuilder: (_, index) => RestaurantCard(
                      onPressed: () => FCoordinator.pushNamed(
                        Routes.restaurant.name,
                        extra: state.restaurants![index],
                      ),
                      restaurant: state.restaurants![index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
