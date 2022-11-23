import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        Assets.images.banner.banner.path,
        fit: BoxFit.cover,
      ),
    );
  }
}
