import 'package:flutter/material.dart';

import '../config/routes/coordinator.dart';
import '../modules/home/widgets/restaurant_card.dart';
import '../repositories/restaurants/restaurant_model.dart';

class RestaurantListView extends StatelessWidget {
  const RestaurantListView({
    super.key,
    required this.restaurants,
  });

  final List<FRestaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          restaurants.length,
          (index) => Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 12.0, 30.0),
            child: RestaurantCard(
              onPressed: () => FCoordinator.goNamed(
                Routes.restaurant.name,
                extra: restaurants[index],
              ),
              restaurant: restaurants[index],
            ),
          ),
        ),
      ),
    );
  }
}
