import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/constants.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/page_arguments/view_more_food_argument.dart';
import '../../../utils/ui/loading/food_card_loading.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/app_bar.dart';
import '../widgets/food_card.dart';
import 'cubit/view_more_cubit.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({
    super.key,
    required this.argument,
  });

  final ViewMoreFoodsArgument argument;

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen> {
  late final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.argument.cubit.initViewMoreFood(widget.argument.foods);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    widget.argument.cubit.close();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 200.0) {
      return;
    }
    widget.argument.onFetchMoreItems.call();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.argument.cubit,
      child: FScaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FAppBar(title: widget.argument.title),
            ),
            Flexible(
              child: BlocBuilder<ViewMoreCubit, ViewMoreState>(
                buildWhen: (previous, current) =>
                    previous.foods != current.foods,
                builder: (context, state) {
                  return state.foods.when(
                    error: (message, previousData) => _FoodListView(
                      controller: _scrollController,
                      foods: previousData,
                      errorMessage: message,
                    ),
                    loading: (previousData) => _FoodListView(
                      controller: _scrollController,
                      foods: previousData,
                      isLoading: true,
                    ),
                    empty: (previousData) => _FoodListView(
                      controller: _scrollController,
                      foods: previousData,
                    ),
                    data: (data) => _FoodListView(
                      controller: _scrollController,
                      foods: data,
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

class _FoodListView extends StatelessWidget {
  const _FoodListView({
    this.controller,
    this.foods,
    this.errorMessage,
    this.isLoading = false,
  });

  final ScrollController? controller;
  final List<FFood>? foods;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    const cardPadding = EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0);
    return foods == null
        ? const SizedBox()
        : ListView(
            controller: controller,
            children: [
              ...List.generate(
                foods!.length,
                (index) => Padding(
                  padding: cardPadding,
                  child: FoodCard(
                    food: foods![index],
                    onPressed: () {
                      FCoordinator.pushNamed(
                        Routes.food.name,
                        extra: foods![index],
                      );
                    },
                  ),
                ),
              )..addAll(isLoading
                  ? List.generate(
                      4,
                      (_) => const Padding(
                            padding: cardPadding,
                            child: Shimmer(
                              gradient: FColors.shimmerGradient,
                              child: FoodCardLoading(),
                            ),
                          ))
                  : [const SizedBox()]),
              errorMessage == null ? const SizedBox() : Text(errorMessage!)
            ],
          );
  }
}
