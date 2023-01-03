import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/ui.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../utils/ui/loading/restaurant_card_loading.dart';
import '../../../utils/ui/scaffold.dart';
import '../../../widgets/app_bar.dart';
import '../../cubits/app/app_cubit.dart';
import '../widgets/restaurant_card.dart';
import 'cubit/view_more_cubit.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({
    super.key,
    required this.restaurants,
  });

  final List<FRestaurant> restaurants;

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  late final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ViewMoreCubit>().initViewMoreRestaurant(
          widget.restaurants,
          context.read<AppCubit>().state.user!.coordinates.first,
        );
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 200.0) {
      return;
    }
    context.read<ViewMoreCubit>().fetchNextNearestRestaurantBatch(
        context.read<AppCubit>().state.user!.coordinates.first);
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: FAppBar(title: 'Nearest Restaurants'),
          ),
          Flexible(
            child: BlocBuilder<ViewMoreCubit, ViewMoreState>(
              buildWhen: (previous, current) =>
                  previous.restaurants != current.restaurants,
              builder: (context, state) {
                return state.restaurants.when(
                  error: (message, previousData) => _RestaurantsListView(
                    controller: _scrollController,
                    restaurants: previousData,
                    errorMessage: message,
                  ),
                  loading: (previousData) => _RestaurantsListView(
                    controller: _scrollController,
                    restaurants: previousData,
                    isLoading: true,
                  ),
                  empty: (previousData) => _RestaurantsListView(
                    controller: _scrollController,
                    restaurants: previousData,
                  ),
                  data: (restaurants) => _RestaurantsListView(
                    controller: _scrollController,
                    restaurants: restaurants,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _RestaurantsListView extends StatelessWidget {
  const _RestaurantsListView({
    this.controller,
    this.restaurants,
    this.isLoading = false,
    this.errorMessage,
  });

  final ScrollController? controller;
  final List<FRestaurant>? restaurants;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return restaurants == null
        ? const SizedBox()
        : Column(
            children: [
              Expanded(
                child: GridView(
                  controller: controller,
                  padding: Ui.screenPadding,
                  cacheExtent: 500.0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
                  ),
                  children: [
                    ...List.generate(
                      restaurants!.length,
                      (index) => RestaurantCard(
                        onPressed: () => FCoordinator.pushNamed(
                          Routes.restaurant.name,
                          extra: restaurants![index],
                        ),
                        restaurant: restaurants![index],
                      ),
                    )..addAll(isLoading
                        ? List.generate(
                            5,
                            (index) => const Shimmer(
                                gradient: FColors.shimmerGradient,
                                child: RestaurantCardLoading()),
                          )
                        : []),
                  ],
                ),
              ),
              Text(errorMessage ?? ''),
            ],
          );
  }
}
