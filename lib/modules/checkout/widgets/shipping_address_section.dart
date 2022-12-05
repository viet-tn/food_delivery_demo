import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../repositories/users/coordinate.dart';
import '../../cubit/app_cubit.dart';
import 'editable_section_bar.dart';

class ShippingAdressSection extends StatelessWidget {
  const ShippingAdressSection({
    super.key,
    required this.name,
    required this.phone,
    required this.address,
  });

  final String name;
  final String phone;
  final String address;

  @override
  Widget build(BuildContext context) {
    final textStyle = FTextStyles.body.copyWith(
      color: const Color(0xFFF79D65),
    );
    return Column(
      children: [
        BlocSelector<AppCubit, AppState, Coordinate>(
          selector: (state) => state.user!.coordinates.first,
          builder: (context, state) {
            return EditableSectionBar(
              onEditPressed: () {
                FCoordinator.showMapScreen(state.latitude, state.longtitude);
              },
              title: 'Shipping Address',
            );
          },
        ),
        gapH8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: FColors.backButtonBgColor.withOpacity(.3),
                shape: BoxShape.circle,
              ),
              height: 40.0,
              child: Image.asset(
                Assets.icons.locationPinOutlined.path,
                fit: BoxFit.contain,
                color: const Color(0xFFF56E1B),
              ),
            ),
            gapW24,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textStyle,
                  ),
                  Text(
                    phone,
                    style: textStyle,
                  ),
                  gapH8,
                  Text(
                    address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
