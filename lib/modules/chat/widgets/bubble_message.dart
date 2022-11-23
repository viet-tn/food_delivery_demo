import 'package:flutter/material.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/ui_parameters.dart';

class BubbleMessage extends StatelessWidget {
  const BubbleMessage({
    super.key,
    required this.content,
    required this.isMyMessage,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  });

  final String content;
  final bool isMyMessage;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return isMyMessage
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              gapW64,
              Flexible(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: Ui.borderRadius,
                    gradient: FColors.linearGradient,
                  ),
                  padding: contentPadding,
                  child: Text(
                    content,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: Ui.borderRadius,
                    color: Colors.grey[100],
                  ),
                  padding: contentPadding,
                  child: Text(
                    content,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              gapW64,
            ],
          );
  }
}
