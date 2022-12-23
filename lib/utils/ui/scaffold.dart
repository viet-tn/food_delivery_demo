import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class FScaffold extends StatelessWidget {
  const FScaffold({
    super.key,
    required this.body,
    this.centerBottomButton,
    this.bottomNavigationBar,
  });

  final Widget body;
  final Widget? centerBottomButton;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.images.splash.bgPattern.path,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: body,
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: centerBottomButton ?? const SizedBox(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Material(
          child: bottomNavigationBar,
        ),
      ),
    );
  }
}
