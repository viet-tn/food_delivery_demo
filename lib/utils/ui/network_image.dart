import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/ui/colors.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';

class FNetworkImage extends StatelessWidget {
  const FNetworkImage(
    this.url, {
    super.key,
    this.fit = BoxFit.contain,
  });

  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (_, __, ___) => Shimmer(
        gradient: FColors.shimmerGradient,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: Ui.borderRadius,
            color: FColors.loading,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Image.asset(Assets.icons.icon.path),
    );
  }
}
