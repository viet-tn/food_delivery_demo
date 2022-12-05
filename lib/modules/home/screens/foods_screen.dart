import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../config/routes/coordinator.dart';
import '../../../utils/ui/listen_error.dart';
import '../../../utils/ui/loading/food_list_loading.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/app_bar.dart';
import '../widgets/food_card.dart';
import 'cubit/view_more_cubit.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({super.key});

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  late final _scrollController = ScrollController();
  late final _cubit = GetIt.I<ViewMoreCubit>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _cubit.fetchFistPopularFoodBatch();
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
        _cubit.fetchNextPopularFoodBatch();
        log('fetchNextFoodBatch');
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
              child: FAppBar(title: 'Popular Food'),
            ),
            Flexible(
              child: BlocBuilder<ViewMoreCubit, ViewMoreState>(
                bloc: _cubit,
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.foods?.length != current.foods?.length,
                builder: (context, state) {
                  if (state.foods == null) {
                    return const SingleChildScrollView(
                        child: FoodListLoading());
                  }

                  if (state.foods!.isEmpty) {
                    return const Text('Empty');
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.foods!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0),
                        child: FoodCard(
                          food: state.foods![index],
                          onPressed: () {
                            FCoordinator.pushNamed(
                              Routes.food.name,
                              extra: state.foods![index],
                            );
                          },
                        ),
                      );
                    },
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
