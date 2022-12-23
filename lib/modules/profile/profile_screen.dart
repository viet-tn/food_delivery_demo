import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../utils/ui/listen_error.dart';
import '../../utils/ui/network_image.dart';
import '../../utils/ui/scrollable_screen_with_background.dart';
import '../../widgets/buttons/logout_button.dart';
import '../cubits/app/app_cubit.dart';
import '../cubits/favorite/favorite_cubit.dart';
import 'widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        FCoordinator.goNamed(Routes.home.name);
        return false;
      },
      child: ListenError<AppCubit>(
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.status != current.status ||
              previous.user != current.user,
          builder: (_, state) {
            if (state.status.isLoading) {
              return const SafeArea(
                child: Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
              );
            }
            return ScrollableScreenWithBackground(
              padding: Ui.screenPadding,
              backgroundImage: FNetworkImage(
                state.user!.photo!,
                fit: BoxFit.cover,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      MemberChip(text: 'Member Gold'),
                      LogoutButton(),
                    ],
                  ),
                  gapH8,
                  InfomationSection(
                    onEditPressed: () =>
                        FCoordinator.goNamed(Routes.editProfile.name),
                    name: '${state.user!.firstName} ${state.user!.lastName}',
                    email: state.user!.email!,
                  ),
                  gapH12,
                  const VoucherCountSection(),
                  gapH24,
                  const Text(
                    'Favorite',
                    style: FTextStyles.heading4,
                  ),
                  BlocBuilder<FavoriteCubit, FavoriteState>(
                    buildWhen: (previous, current) =>
                        previous.foods != current.foods,
                    builder: (_, state) {
                      return FavoriteSection(
                        foodList: state.foods,
                      );
                    },
                  ),
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
