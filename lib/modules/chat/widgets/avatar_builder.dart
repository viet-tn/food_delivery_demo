import 'package:flutter/material.dart';

import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/domain_manager.dart';
import '../../../utils/helpers/image_converter.dart';

class AvatarBuilder extends StatelessWidget {
  const AvatarBuilder({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DomainManager().userRepository.getBase64ProfileImage(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: Ui.borderRadius,
            child: ImageConverter.imageFromBase64String(snapshot.data!),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
