import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../config/routes/coordinator.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../repositories/chat/chat_model.dart';
import '../../../utils/helpers/date_helpers.dart';
import '../../login/cubit/login_cubit.dart';
import '../cubit/chat_cubit.dart';
import 'widgets.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.chats,
    required this.myUserId,
  });

  final List<FChat> chats;
  final String myUserId;

  @override
  Widget build(BuildContext context) {
    return chats.isEmpty
        ? const Center(
            child: Text('No chat'),
          )
        : ListView(
            children: List.generate(
              chats.length,
              (index) {
                final chat = chats[index];
                final chatWithUserId = chat.userIds.firstWhere(
                  (element) => element != myUserId,
                );
                return Padding(
                  padding: Ui.screenPadding,
                  child: ChatCard(
                    onPressed: () {
                      context
                          .read<ChatCubit>()
                          .readMessage(chat.id, chat.lastestMessage);
                      FCoordinator.goNamed(
                        Routes.chatDetail.name,
                        params: {
                          'chatId': chat.id,
                          'chatWithUserId': chatWithUserId,
                        },
                      );
                    },
                    withUserId: chatWithUserId,
                    lastMessage: chat.lastestMessage.content,
                    lastMessageTime: DateTime.fromMillisecondsSinceEpoch(
                            chat.lastestMessage.timeStamp)
                        .timeString,
                    isSeen: chat.lastestMessage.isSeen,
                    isMyMessage: chat.lastestMessage.senderId ==
                        GetIt.I<LoginCubit>().state.user.id,
                  ),
                );
              },
            )..add(Sizes.navBarGapH),
          );
  }
}
