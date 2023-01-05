import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../gen/assets.gen.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !isLoading,
      child: Stack(
        children: [
          child,
          isLoading
              ? Container(
                  color: Colors.black.withOpacity(.3),
                  child: Center(
                    child: Lottie.asset(Assets.lotties.loadingWhite),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
