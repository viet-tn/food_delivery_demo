import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/routes/coordinator.dart';
import 'package:get_it/get_it.dart';

import '../../constants/app_constants.dart';
import '../../constants/ui/colors.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../gen/assets.gen.dart';
import '../../repositories/food/food_model.dart';
import '../../utils/helpers/text_helpers.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/network_image.dart';
import '../../utils/ui/scrollable_screen_with_background.dart';
import '../../widgets/buttons/gradient_button.dart';
import '../../widgets/buttons/icon_button.dart';
import '../../widgets/chips/category_chip.dart';
import '../../widgets/testimonial_section.dart';
import 'cubit/food_cubit.dart';
import 'widgets/food_rating.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({
    super.key,
    required this.food,
  });

  final FFood food;

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late final FoodCubit _cubit = GetIt.I<FoodCubit>()..init(widget.food);

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => _cubit,
      child: ListenError<FoodCubit>(
        child: BlocBuilder<FoodCubit, FoodState>(
          builder: (context, state) {
            return ScrollableScreenWithBackground(
              backgroundImage: FNetworkImage(state.food!.img),
              bottomCenterButton: AddToCartButton(
                onPressed: () => _cubit.addToCart(),
                isAdded: state.isAddedToCart,
                isLoading: state.status.isLoading,
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
                            CategoryChip(
                                text: state.food!.category
                                    .foodCategoryProcessor()),
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
                              onTap: () => context
                                  .read<FoodCubit>()
                                  .toggleFavoriteList(
                                      state.isAddToFavoriteList),
                              icon: Icon(
                                state.isAddToFavoriteList
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.red,
                              ),
                              color: Colors.red.withOpacity(.1),
                            )
                          ],
                        ),
                        gapH20,
                        Text(
                          state.food!.name,
                          style: FTextStyles.heading1,
                        ),
                        gapH20,
                        const FoodRating(),
                        gapH20,
                        const Text(
                          foodDescription,
                          style: FTextStyles.description,
                        ),
                      ],
                    ),
                  ),
                  const TestimonialSection(),
                  Sizes.navBarGapH,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.isAdded,
    this.isLoading = false,
    this.onPressed,
  });

  final bool isAdded;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GradientButton(
        onPressed:
            isAdded ? () => FCoordinator.goNamed(Routes.cart.name) : onPressed,
        height: 70.0,
        width: double.infinity,
        gradient: FColors.linearGradient,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                isAdded ? 'Go To Cart' : 'Add To Cart',
                style: FTextStyles.button.copyWith(fontSize: 18.0),
              ),
      ),
    );
  }
}
