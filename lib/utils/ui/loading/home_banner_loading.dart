import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/ui_parameters.dart';

class HomeBannerLoading extends StatelessWidget {
  const HomeBannerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: FColors.shimmerGradient,
      child: Container(
        height: 170,
        decoration: const BoxDecoration(
          borderRadius: Ui.borderRadius,
          color: FColors.loading,
        ),
      ),
    );
  }
}
