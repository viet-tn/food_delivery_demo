import 'package:flutter/material.dart';

import '../../../constants/ui/sizes.dart';
import '../../../repositories/chat/messages/message_model.dart';
import 'bubble_message.dart';

class ChatDetailContents extends StatelessWidget {
  const ChatDetailContents({
    super.key,
    this.isLoading = false,
    required this.messages,
    required this.myUserId,
    this.controller,
    this.onRefresh,
  });

  final bool isLoading;
  final Future<void> Function()? onRefresh;
  final List<FMessage> messages;
  final String myUserId;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: RefreshIndicator(
              onRefresh: () async {
                onRefresh?.call();
              },
              child: ListView(
                controller: controller,
                children: [
                  Sizes.navBarGapH,
                  ...List.generate(
                    messages.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 4.0,
                        ),
                        child: BubbleMessage(
                          content: messages[index].content,
                          isMyMessage: messages[index].senderId == myUserId,
                        ),
                      );
                    },
                  ),
                  gapH12,
                ],
              ),
            ),
          );
  }
}
