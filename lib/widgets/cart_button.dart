import 'package:flutter/material.dart';

import '../constants/ui/colors.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    super.key,
    this.itemCount = 0,
    this.hasBackground = true,
    this.onTap,
  });

  final int itemCount;
  final bool hasBackground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: hasBackground ? const Color(0x44FFFFFF) : Colors.transparent,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10.0),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: hasBackground
                          ? FColors.lightGreen
                          : Colors.transparent,
                      size: 30.0,
                    ),
                  ),
                  itemCount > 0 && hasBackground
                      ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.only(
                            left: 2.0,
                            bottom: 2.0,
                          ),
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                itemCount.toString(),
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
