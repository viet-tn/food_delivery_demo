import 'package:flutter/material.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/users/user_model.dart';
import '../../../utils/ui/network_image.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../repositories/users/coordinate.dart';
import '../../../utils/ui/card.dart';
import '../../../widgets/buttons/icon_button.dart';

class CurrentOrderCard extends StatelessWidget {
  const CurrentOrderCard({
    super.key,
    required this.source,
    required this.destination,
    required this.shipper,
  });

  final Coordinate source;
  final Coordinate destination;
  final FUser shipper;

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: () => FCoordinator.pushNamed(
        Routes.orderTracking.name,
        extra: [
          source,
          destination,
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: Ui.borderRadius,
            child: SizedBox.square(
              dimension: 60.0,
              child: FNetworkImage(
                shipper.photo!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          gapW12,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '15 - 25 mins',
                  style: FTextStyles.heading3,
                ),
                Text(
                  'Estimated delivery time',
                  style: FTextStyles.label.copyWith(fontSize: 12.0),
                ),
              ],
            ),
          ),
          Row(
            children: [
              FIconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.message_outlined,
                  color: FColors.green,
                ),
              ),
              gapW4,
              FIconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call_outlined,
                  color: FColors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
