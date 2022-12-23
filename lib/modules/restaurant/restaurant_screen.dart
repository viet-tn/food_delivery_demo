import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../constants/app_constants.dart';
import '../../constants/ui/colors.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../gen/assets.gen.dart';
import '../../repositories/restaurants/restaurant_model.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/network_image.dart';
import '../../utils/ui/scrollable_screen_with_background.dart';
import '../../widgets/buttons/icon_button.dart';
import '../../widgets/chips/category_chip.dart';
import '../../widgets/testimonial_section.dart';
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
      child: ListenError<RestaurantCubit>(
        child: BlocBuilder<RestaurantCubit, RestaurantState>(
          buildWhen: (previous, current) =>
              previous.restaurant != current.restaurant,
          builder: (context, state) {
            return ScrollableScreenWithBackground(
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
                          children: [
                            const CategoryChip(text: 'Popular'),
                            const Spacer(),
                            FIconButtonn(
                              onTap: () {},
                              icon: Image.asset(
                                Assets.icons.locationPin.path,
                                fit: BoxFit.contain,
                              ),
                              color: FColors.lightGreen.withOpacity(.2),
                            ),
                            gapW8,
                            FIconButtonn(
                              onTap: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              color: Colors.red.withOpacity(.1),
                            )
                          ],
                        ),
                        gapH20,
                        Text(
                          state.restaurant!.name,
                          style: FTextStyles.heading1,
                        ),
                        gapH20,
                        RestaurantRating(
                          meters: widget.restaurant.distance!,
                        ),
                        gapH20,
                        const Text(
                          restaurantDescription,
                          style: FTextStyles.description,
                        ),
                      ],
                    ),
                  ),
                  state.foods.isNotEmpty
                      ? PopularBriefFoodSection(foods: state.foods)
                      : FutureBuilder(
                          future: context.read<RestaurantCubit>().fetchFoods(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return PopularBriefFoodSection(
                                foods: snapshot.data!);
                          },
                        ),
                  gapH12,
                  const TestimonialSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
