import 'package:flutter/material.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../repositories/food/food_model.dart';
import 'brief_food_card.dart';

class PopularBriefFoodSection extends StatelessWidget {
  const PopularBriefFoodSection({super.key, required this.foods});

  final List<FFood> foods;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Menu',
                style: FTextStyles.heading4,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View More',
                  style:
                      FTextStyles.label.copyWith(color: FColors.metallicOrange),
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              foods.length,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 190,
                  width: 130,
                  child: BriefFoodCard(
                    onPressed: () => FCoordinator.pushNamed(
                      Routes.food.name,
                      extra: foods[index],
                    ),
                    food: foods[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
