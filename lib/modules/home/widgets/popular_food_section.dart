import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/page_arguments/view_more_food_argument.dart';
import '../../../utils/ui/loading/food_list_loading.dart';
import '../../../widgets/food_list_view.dart';
import '../screens/cubit/view_more_cubit.dart';

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
                onPressed: () {
                  final cubit = GetIt.I<ViewMoreCubit>();
                  FCoordinator.pushNamed(
                    Routes.foods.name,
                    extra: ViewMoreFoodsArgument(
                      cubit: cubit,
                      title: 'Popular Menu',
                      foods: foods,
                      onFetchMoreItems: cubit.fetchNextPopularFoodBatch,
                    ),
                  );
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
        isLoading ? const FoodListLoading() : FoodListView(foods: foods),
      ],
    );
  }
}
