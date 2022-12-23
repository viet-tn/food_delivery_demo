import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/users/coordinate.dart';
import '../../../repositories/users/user_model.dart';
import '../../../utils/helpers/text_helpers.dart';
import '../../../utils/ui/card.dart';
import '../../../utils/ui/network_image.dart';
import '../../../widgets/buttons/icon_button.dart';

class CurrentOrderCard extends StatelessWidget {
  const CurrentOrderCard({
    super.key,
    required this.chatId,
    required this.source,
    required this.destination,
    required this.shipper,
    this.deliveryTime,
  });

  final String chatId;
  final Coordinate source;
  final Coordinate destination;
  final FUser shipper;
  final int? deliveryTime;

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
                deliveryTime == null
                    ? const SizedBox()
                    : Text(
                        StringExtension.toTime(deliveryTime!),
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
                onPressed: () {
                  FCoordinator.pushNamed(
                    Routes.chat.name,
                    params: {
                      'chatId': chatId,
                      'chatWithUserId': shipper.id,
                    },
                  );
                },
                icon: const Icon(
                  Icons.message_outlined,
                  color: FColors.green,
                ),
              ),
              gapW4,
              FIconButton(
                onPressed: () => launchUrlString('tel://${shipper.phone!}'),
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
