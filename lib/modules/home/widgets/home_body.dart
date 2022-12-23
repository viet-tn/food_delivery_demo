import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../cubit/home_cubit.dart';
import 'home_banner_section.dart';
import 'nearest_restaurant_section.dart';
import 'popular_food_section.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return const Padding(
                  padding: Ui.screenPaddingHorizontal,
                  child: HomeBannerSection(),
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
                  isLoading:
                      state.status.isLoading && state.restaurants.isEmpty,
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
                  isLoading: state.status.isLoading && state.foods.isEmpty,
                  foods: state.foods,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
