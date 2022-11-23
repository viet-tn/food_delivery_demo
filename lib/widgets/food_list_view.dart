import 'package:flutter/material.dart';

import '../config/routes/coordinator.dart';
import '../constants/ui/sizes.dart';
import '../modules/home/widgets/food_card.dart';
import '../repositories/food/food_model.dart';

class FoodListView extends StatelessWidget {
  const FoodListView({
    super.key,
    required this.foods,
    this.controller,
    this.isLoading = false,
  });

  final List<FFood> foods;
  final ScrollController? controller;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: List.generate(
          foods.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 15.0,
            ),
            child: FoodCard(
              onPressed: () => FCoordinator.pushNamed(
                Routes.food.name,
                extra: foods[index],
              ),
              food: foods[index],
            ),
          ),
        )
          ..add(
            isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox(),
          )
          ..add(Sizes.navBarGapH),
      ),
    );
  }
}
