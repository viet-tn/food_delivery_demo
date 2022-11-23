import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../cubit/home_cubit.dart';
import 'home_banner_section.dart';
import 'nearest_restaurant_section.dart';
import 'popular_food_section.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ScrollController _scrollController;
  var preventCall = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() async {
        double currentScroll = _scrollController.position.pixels;
        double maxScroll = _scrollController.position.maxScrollExtent;
        const fetchOffset = 400.0;
        if (currentScroll > maxScroll - fetchOffset && !preventCall) {
          // 200 is offset
          preventCall = true;
          await context.read<HomeCubit>().fetchNextFoodBatch();
          preventCall = false;
        }
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: SizedBox(
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return Padding(
                  padding: Ui.screenPaddingHorizontal,
                  child: HomeBannerSection(
                    isLoading: state.status.isLoading,
                  ),
                );
              },
            ),
            gapH16,
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.restaurants != current.restaurants,
              builder: (context, state) {
                return NearestRestaurantSection(
                  isLoading: state.status.isLoading,
                  restaurants: state.restaurants,
                );
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.foods != current.foods,
              builder: (_, state) {
                return PopularFoodSection(
                  isLoading: state.status.isLoading,
                  foods: state.foods,
                );
              },
            ),
            Sizes.navBarGapH,
          ],
        ),
      ),
    );
  }
}
