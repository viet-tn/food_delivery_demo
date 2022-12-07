import 'package:flutter/material.dart';
import '../../../config/routes/coordinator.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../utils/ui/loading/restaurant_list_loading.dart';
import '../../../widgets/restaurant_list_view.dart';

class NearestRestaurantSection extends StatelessWidget {
  const NearestRestaurantSection({
    super.key,
    required this.restaurants,
    this.isLoading = false,
  });

  final List<FRestaurant> restaurants;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: Ui.screenPaddingHorizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nearest Restaurant',
                style: FTextStyles.heading4,
              ),
              TextButton(
                onPressed: () {
                  FCoordinator.pushNamed(Routes.restaurants.name);
                },
                child: Text(
                  'View More',
                  style:
                      FTextStyles.label.copyWith(color: FColors.metallicOrange),
                ),
              ),
            ],
          ),
        ),
        isLoading
            ? const RestaurantListLoading()
            : RestaurantListView(restaurants: restaurants),
      ],
    );
  }
}
