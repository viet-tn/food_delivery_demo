import 'package:flutter/material.dart';

import '../../../utils/ui/loading/home_banner_loading.dart';
import 'home_banner.dart';

class HomeBannerSection extends StatelessWidget {
  const HomeBannerSection({
    super.key,
    this.isLoading = false,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading ? const HomeBannerLoading() : const HomeBanner();
  }
}
