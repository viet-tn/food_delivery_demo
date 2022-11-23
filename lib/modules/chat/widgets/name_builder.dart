import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/domain_manager.dart';

class NameBuilder extends StatelessWidget {
  const NameBuilder({
    super.key,
    required this.userId,
    this.style = FTextStyles.heading5,
  });

  final String userId;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DomainManager().userRepository.getName(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data!,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }
        return SizedBox(
          height: 20.0,
          width: 100.0,
          child: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: FColors.lightGreen,
            period: const Duration(seconds: 1),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: Ui.borderRadius,
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
