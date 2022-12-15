import 'package:flutter/material.dart';

import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/domain_manager.dart';
import '../../../utils/ui/network_image.dart';

class AvatarBuilder extends StatelessWidget {
  const AvatarBuilder({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DomainManager().userRepository.getImage(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: Ui.borderRadius,
            child: FNetworkImage(
              snapshot.data!,
              fit: BoxFit.cover,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
