import 'dart:async';

import 'package:flutter/material.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/sizes.dart';
import '../../modules/profile/widgets/drag_icon.dart';
import '../../widgets/buttons/back_button.dart';

class ScrollableScreenWithBackground extends StatefulWidget {
  const ScrollableScreenWithBackground({
    super.key,
    required this.backgroundImage,
    this.bottomCenterButton,
    this.padding = const EdgeInsets.symmetric(vertical: 15.0),
    required this.child,
  });

  final Widget backgroundImage;
  final Widget? bottomCenterButton;
  final Widget child;
  final EdgeInsets padding;

  @override
  State<ScrollableScreenWithBackground> createState() =>
      _ScrollableScreenWithBackgroundState();
}

class _ScrollableScreenWithBackgroundState
    extends State<ScrollableScreenWithBackground> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();

    _controllerHandler();
  }

  void _controllerHandler() {
    if (_controller.hasClients) {
      _controller.animateTo(
        _controller.position.maxScrollExtent * .4,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
      );
    } else {
      Timer(const Duration(milliseconds: 50), _controllerHandler);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox.fromSize(
              size: Size.fromHeight(size.width),
              child: widget.backgroundImage,
            ),
            SingleChildScrollView(
              controller: _controller,
              child: Column(
                children: [
                  SizedBox.fromSize(
                    size: Size.fromHeight(size.width * .8),
                    // Disable SingleChildScrollView's scrolling
                    child: GestureDetector(
                      onVerticalDragUpdate: (_) {},
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        gapH16,
                        const DragIcon(),
                        gapH24,
                        NotificationListener<OverscrollNotification>(
                          onNotification: (value) {
                            // Don't handle overscroll in horizontal direction
                            if (value.metrics.axis == Axis.horizontal) {
                              return true;
                            }

                            // if [FavoriteSection] overscroll on top &&
                            // [ProfileBody]'s scroll position +
                            if (value.overscroll < 0 &&
                                _controller.offset + value.overscroll <= 0) {
                              if (_controller.offset != 0) {
                                _controller.jumpTo(0);
                              }
                            }
                            if (_controller.offset + value.overscroll >=
                                _controller.position.maxScrollExtent) {
                              if (_controller.offset !=
                                  _controller.position.maxScrollExtent) {
                                _controller.jumpTo(
                                    _controller.position.maxScrollExtent);
                              }
                              return true;
                            }
                            _controller
                                .jumpTo(_controller.offset + value.overscroll);
                            return true;
                          },
                          child: SizedBox(
                            height: size.height * .75,
                            // [state.user] cannot null because of [_init]
                            // function in cubit
                            child: SingleChildScrollView(
                              padding: widget.padding,
                              child: SizedBox(
                                width: double.infinity,
                                child: widget.child,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.bottomCenterButton != null
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: widget.bottomCenterButton,
                  )
                : const SizedBox(),
            FCoordinator.canPop()
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 5.0),
                      child: FBackButton(),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
