import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../utils/ui/card.dart';
import 'avatar_builder.dart';
import 'name_builder.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({
    super.key,
    required this.userId,
    required this.lastSeen,
  });

  final String userId;
  final int lastSeen;

  @override
  Widget build(BuildContext context) {
    return FCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox.square(
            dimension: 70.0,
            child: AvatarBuilder(userId: userId),
          ),
          gapW12,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameBuilder(userId: userId),
              OnlineStatus(lastSeen: lastSeen),
            ],
          )
        ],
      ),
    );
  }
}

class OnlineStatus extends StatelessWidget {
  const OnlineStatus({
    super.key,
    required this.lastSeen,
  });

  /// Measurement: minute
  final int lastSeen;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10.0,
          width: 10.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: FColors.lightGreen,
          ),
        ),
        gapW4,
        const Text('Online'),
      ],
    );
  }
}
