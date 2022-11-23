import 'package:flutter/material.dart';

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
                  color: Colors.grey.withOpacity(.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
