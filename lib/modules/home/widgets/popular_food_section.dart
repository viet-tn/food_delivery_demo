import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/loading/food_list_loading.dart';
import '../../../widgets/food_list_view.dart';

class PopularFoodSection extends StatelessWidget {
  const PopularFoodSection({
    super.key,
    required this.foods,
    this.isLoading = false,
  });

  final List<FFood> foods;
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
        isLoading ? const FoodListLoading() : FoodListView(foods: foods),
      ],
    );
  }
}
