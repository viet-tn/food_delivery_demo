import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../utils/ui/card.dart';
import 'widgets.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.withUserId,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isSeen,
    required this.isMyMessage,
    this.onPressed,
  });

  final String withUserId;
  final String lastMessage;
  final String lastMessageTime;
  final bool isSeen;
  final bool isMyMessage;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FCard(
      onTap: () => onPressed?.call(),
      child: Row(
        children: [
          SizedBox.square(
            dimension: 60.0,
            child: AvatarBuilder(
              userId: withUserId,
            ),
          ),
          gapW8,
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameBuilder(userId: withUserId),
                gapH4,
                Text(
                  lastMessage,
                  style: isSeen || isMyMessage
                      ? FTextStyles.label.copyWith(color: Colors.grey)
                      : FTextStyles.label.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          gapH12,
          Text(
            lastMessageTime,
            style: isSeen || isMyMessage
                ? FTextStyles.label.copyWith(color: Colors.grey)
                : FTextStyles.label.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
