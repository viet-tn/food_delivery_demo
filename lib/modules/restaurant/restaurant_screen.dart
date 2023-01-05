import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../constants/app_constants.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../gen/assets.gen.dart';
import '../../repositories/restaurants/restaurant_model.dart';
import '../../utils/ui/loading/restaurant_list_loading.dart';
import '../../utils/ui/network_image.dart';
import '../../utils/ui/scrollable_screen_with_background.dart';
import '../../widgets/chips/category_chip.dart';
import '../../widgets/testimonial_section.dart';
import '../chat/widgets/loading_indicator.dart';
import '../home/screens/cubit/view_more_cubit.dart';
import 'cubit/restaurant_cubit.dart';
import 'widgets/popular_brief_food_section.dart';
import 'widgets/restaurant_rating.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({
    super.key,
    required this.restaurant,
  });

  final FRestaurant restaurant;

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late final RestaurantCubit _cubit = GetIt.I<RestaurantCubit>()
    ..init(widget.restaurant);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: BlocBuilder<RestaurantCubit, RestaurantState>(
        buildWhen: (previous, current) =>
            previous.restaurant != current.restaurant ||
            previous.star != current.star,
        builder: (context, state) {
          return state.restaurant.maybeWhen(
            orElse: () => const SizedBox(),
            data: (restaurant) => ScrollableScreenWithBackground(
              backgroundImage: const FNetworkImage(
                'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                fit: BoxFit.cover,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: FTextStyles.heading1,
                            ),
                            const CategoryChip(text: 'Popular'),
                          ],
                        ),
                        gapH20,
                        RestaurantRating(
                          meters: widget.restaurant.distance!,
                          rating: state.star.maybeWhen(
                            data: (star) => star.average,
                            orElse: () => 0.0,
                          ),
                        ),
                        gapH20,
                        const Text(
                          restaurantDescription,
                          style: FTextStyles.description,
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<RestaurantCubit, RestaurantState>(
                    buildWhen: (previous, current) =>
                        previous.foods != current.foods,
                    builder: (context, state) => state.foods.when(
                      error: (message, _) => Center(child: Text(message)),
                      loading: (_) => const RestaurantListLoading(),
                      empty: (_) => const Text('Empty'),
                      data: (foods) => PopularBriefFoodSection(
                        foods: foods,
                        restaurant: restaurant,
                        onFetchMoreFood: () => context
                            .read<ViewMoreCubit>()
                            .fetchNextRestaurantFoodBatch(restaurant.foodIds),
                      ),
                    ),
                  ),
                  gapH12,
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Ratings and Reviews',
                      style: FTextStyles.heading4,
                    ),
                  ),
                  BlocBuilder<RestaurantCubit, RestaurantState>(
                    buildWhen: (previous, current) =>
                        previous.star != current.star,
                    builder: (context, state) => state.star.when(
                      error: (message, _) => Text(message),
                      loading: (_) => const Center(
                        child: FLoadingIndicator(),
                      ),
                      empty: (_) => const Text('Empty'),
                      data: (star) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: RatingStatisticalSection(
                          star: star,
                        ),
                      ),
                    ),
                  ),
                  BlocBuilder<RestaurantCubit, RestaurantState>(
                    buildWhen: (previous, current) =>
                        previous.ratings != current.ratings,
                    builder: (context, state) => state.ratings.when(
                      error: (message, _) => Text(message),
                      loading: (_) => const Center(
                        child: FLoadingIndicator(),
                      ),
                      empty: (_) => Center(
                        child: SizedBox.square(
                          dimension: 200.0,
                          child: SvgPicture.asset(
                            Assets.images.illustrations.empty,
                          ),
                        ),
                      ),
                      data: (ratings) => TestimonialSection(ratings: ratings),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
