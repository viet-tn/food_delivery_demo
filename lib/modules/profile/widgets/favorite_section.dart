import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../chat/widgets/dismissible.dart';
import '../../cubits/favorite/favorite_cubit.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../gen/assets.gen.dart';
import '../../../repositories/food/food_model.dart';
import '../../../utils/ui/network_image.dart';

class FavoriteSection extends StatelessWidget {
  const FavoriteSection({
    super.key,
    required this.foodList,
  });

  final List<FFood> foodList;

  @override
  Widget build(BuildContext context) {
    return foodList.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox.square(
                  dimension: 220.0,
                  child: SvgPicture.asset(
                    Assets.images.illustrations.favorite,
                  ),
                ),
                Text(
                  'Your favorite list is empty!',
                  style: FTextStyles.body.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                gapH32,
              ],
            ),
          )
        : Column(
            children: List.generate(
              foodList.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: _FavoriteCard(food: foodList[index]),
              ),
            ),
          );
  }
}

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.food});

  final FFood food;

  @override
  Widget build(BuildContext context) {
    return FDismissible(
      onDismiss: () => context.read<FavoriteCubit>().toggleFavoriteList(food),
      onTap: () => FCoordinator.pushNamed(Routes.food.name, extra: food),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 90,
            child: ClipRRect(
              borderRadius: Ui.borderRadius,
              child: FNetworkImage(
                '${food.img}?fit=scale&w=100&h=100',
                fit: BoxFit.cover,
              ),
            ),
          ),
          gapW12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.heading5,
                ),
                Text(
                  food.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: FTextStyles.label.copyWith(color: Colors.grey),
                ),
                gapH4,
                Text(
                  '\$ ${food.price.toInt()}',
                  style:
                      FTextStyles.heading4.copyWith(color: FColors.lightGreen),
                ),
              ],
            ),
          ),
          gapW4,
        ],
      ),
    );
  }
}
