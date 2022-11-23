import 'package:flutter/material.dart';

import '../../config/routes/coordinator.dart';
import '../../constants/ui/colors.dart';
import '../../constants/ui/sizes.dart';
import '../../constants/ui/text_style.dart';
import '../../constants/ui/ui_parameters.dart';
import '../../gen/assets.gen.dart';

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    super.key,
    required this.location,
    required this.child,
  });

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        child,
        Visibility(
          visible: !keyboardIsOpen,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8.0),
              child: FBottomNavigationBar(
                currentIndex: _locationToIndex(location),
                items: _tabs,
                onTap: _onItemTapped,
              ),
            ),
          ),
        )
      ]),
    );
  }

  int _locationToIndex(String location) {
    switch (location) {
      case '/profile':
        return 1;
      case '/cart':
        return 2;
      case '/chat':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int tabIndex) {
    FCoordinator.goNamed(_tabs[tabIndex].initialLocation);
  }
}

class FBottomNavigationBar extends StatefulWidget {
  const FBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onTap,
  });

  final int currentIndex;
  final List<FBottomBarItem> items;
  final void Function(int index)? onTap;

  @override
  State<FBottomNavigationBar> createState() => _FBottomNavigationBarState();
}

class _FBottomNavigationBarState extends State<FBottomNavigationBar> {
  late int activeTab;

  @override
  Widget build(BuildContext context) {
    activeTab = widget.currentIndex;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 6.0,
      ),
      decoration: const BoxDecoration(
        borderRadius: Ui.borderRadius,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            blurStyle: BlurStyle.outer,
            color: FColors.shadow,
          )
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(widget.items.length, (index) {
          bool isActiveTab = activeTab == index;
          return Container(
            padding: isActiveTab
                ? const EdgeInsets.symmetric(horizontal: 14.0, vertical: 2.0)
                : null,
            decoration: isActiveTab
                ? const BoxDecoration(
                    borderRadius: Ui.borderRadius,
                    gradient: FColors.navBg,
                  )
                : null,
            child: Row(
              children: [
                Opacity(
                  opacity: isActiveTab ? 1.0 : 0.5,
                  child: IconButton(
                    onPressed: isActiveTab
                        ? null
                        : () {
                            setState(() => activeTab = index);
                            widget.onTap?.call(index);
                          },
                    icon: widget.items[index].icon,
                  ),
                ),
                isActiveTab
                    ? Row(
                        children: [
                          gapW12,
                          widget.items[index].title,
                          gapW8,
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class FBottomBarItem {
  const FBottomBarItem({
    required this.initialLocation,
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });

  final String initialLocation;
  final Widget icon;
  final Widget? activeIcon;
  final Widget title;
  final Color? selectedColor;
  final Color? unselectedColor;
}

const _iconScale = 1.4;
final _tabs = <FBottomBarItem>[
  FBottomBarItem(
    initialLocation: Routes.home.name,
    icon: Image.asset(
      Assets.icons.home.path,
      fit: BoxFit.contain,
      scale: _iconScale,
    ),
    title: const Text(
      'Home',
      style: FTextStyles.heading5,
    ),
  ),
  FBottomBarItem(
    initialLocation: Routes.profile.name,
    icon: Image.asset(
      Assets.icons.profileNav.path,
      fit: BoxFit.contain,
      scale: _iconScale,
    ),
    title: const Text(
      'Profile',
      style: FTextStyles.heading5,
    ),
  ),
  FBottomBarItem(
    initialLocation: Routes.cart.name,
    icon: Image.asset(
      Assets.icons.cart.path,
      fit: BoxFit.contain,
      scale: _iconScale,
    ),
    title: const Text(
      'Cart',
      style: FTextStyles.heading5,
    ),
  ),
  FBottomBarItem(
    initialLocation: Routes.chat.name,
    icon: Image.asset(
      Assets.icons.chat.path,
      fit: BoxFit.contain,
      scale: _iconScale,
    ),
    title: const Text(
      'Chat',
      style: FTextStyles.heading5,
    ),
  ),
];
