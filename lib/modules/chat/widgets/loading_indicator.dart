import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../gen/assets.gen.dart';

class FLoadingIndicator extends StatelessWidget {
  const FLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(Assets.lotties.loadingBlack);
  }
}
