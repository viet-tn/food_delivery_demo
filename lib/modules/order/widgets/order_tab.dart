import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/text_style.dart';
import '../../../utils/helpers/text_helpers.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({
    super.key,
    required this.currentIndex,
    required this.items,
    this.onPressed,
  });

  final int currentIndex;
  final List<String> items;
  final void Function(int index)? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: FColors.lightGreen,
        boxShadow: const [
          BoxShadow(
            color: FColors.shadow,
            blurStyle: BlurStyle.outer,
            blurRadius: 20.0,
            spreadRadius: -10.0,
            offset: Offset(5.0, 5.0),
          )
        ],
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: GestureDetector(
                onTap: () {
                  onPressed?.call(index);
                },
                child: Container(
                  height: 50,
                  decoration: currentIndex == index
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            )
                          ],
                        )
                      : const BoxDecoration(),
                  child: Center(
                    child: Text(
                      items[index].capitalize(),
                      style: FTextStyles.button.copyWith(
                        color: currentIndex == index
                            ? FColors.green
                            : Colors.white70,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
