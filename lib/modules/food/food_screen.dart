import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/dialogs/dialog.dart';
import 'package:get_it/get_it.dart';

import '../../config/routes/coordinator.dart';
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
import '../cart/cubit/cart_cubit.dart';
import '../cubits/favorite/favorite_cubit.dart';
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
  late final FoodCubit _foodCubit = GetIt.I<FoodCubit>();

  @override
  void initState() {
    super.initState();
    _foodCubit.init(widget.food);
  }

  @override
  Widget build(BuildContext _) {
    return BlocProvider(
      create: (_) => _foodCubit,
      child: ListenError<FoodCubit>(
        child: BlocBuilder<FoodCubit, FoodState>(
          buildWhen: (previous, current) => previous.food != current.food,
          builder: (_, state) {
            return ScrollableScreenWithBackground(
              backgroundImage: FNetworkImage(state.food!.img),
              bottomCenterButton: BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) => previous.cart != current.cart,
                builder: (context, cartState) {
                  return AddToCartButton(
                    onPressed: () async {
                      if (cartState.cart.items.isEmpty ||
                          cartState.cart.restaurantId ==
                              state.food!.restaurantId) {
                        context.read<CartCubit>().addToCart(state.food!);
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (context) => FAlertDialog(
                          title: 'Are you sure want to reset?',
                          description:
                              'You have food from another restaurant in cart. '
                              'If you continue, your all previous food from art'
                              ' will be removed.',
                          onYesPressed: () {
                            context.read<CartCubit>().clear();
                            context.read<CartCubit>().addToCart(state.food!);
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                    isAdded: cartState.cart.items.containsKey(state.food!.id),
                    isLoading: state.status.isLoading,
                  );
                },
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
                            BlocBuilder<FavoriteCubit, FavoriteState>(
                              buildWhen: (previous, current) =>
                                  previous.favoriteList != current.favoriteList,
                              builder: (context, favoriteState) {
                                if (favoriteState.favoriteList == null) {
                                  return FIconButtonn(
                                    icon: const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.red,
                                    ),
                                    color: Colors.red.withOpacity(.1),
                                  );
                                }
                                return FIconButtonn(
                                  onTap: () => context
                                      .read<FavoriteCubit>()
                                      .toggleFavoriteList(state.food!),
                                  icon: Icon(
                                    favoriteState.favoriteList!.foodIds
                                            .contains(widget.food.id)
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                  color: Colors.red.withOpacity(.1),
                                );
                              },
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
