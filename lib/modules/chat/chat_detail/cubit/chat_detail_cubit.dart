import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../../../base/cubit.dart';
import '../../../../repositories/chat/chat_repository.dart';
import '../../../../repositories/chat/messages/message_model.dart';
import '../../../../repositories/chat/messages/message_repository.dart';
import '../../../login/cubit/login_cubit.dart';
import 'chat_detail_state.dart';

class ChatDetailCubit extends FCubit<ChatDetailState> {
  ChatDetailCubit({
    required MessageRepository messageRepository,
    required ChatRepository chatRepository,
  })  : _messageRepository = messageRepository,
        _chatRepository = chatRepository,
        super(const ChatDetailState());

  final MessageRepository _messageRepository;
  final ChatRepository _chatRepository;
  StreamSubscription? _chatDetailSubscription;

  void init(
    String chatId,
    String chatWithUserId,
  ) async {
    emit(state.copyWith(
      chatId: chatId,
      chatWithUserId: chatWithUserId,
    ));

    _chatDetailSubscription?.cancel();
    _chatDetailSubscription =
        _messageRepository.getStreamMessage(chatId).listen((event) {
      emitValue(state.copyWith(messages: event.reversed.toList()));
    });
  }

  Future<void> fetchMoreMessages(FMessage oldestMessage) async {
    final result =
        await _messageRepository.fetchMessages(state.chatId!, oldestMessage);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state
        .copyWith(messages: [...result.data!.reversed, ...state.messages]));
  }

  void sendMessage(String content) async {
    final newMessage = FMessage(
      chatId: state.chatId!,
      senderId: GetIt.I<LoginCubit>().state.user.id,
      timeStamp: DateTime.now().millisecondsSinceEpoch,
      content: content,
    );
    final result = await _messageRepository.sendMessage(newMessage);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    _chatRepository.updateLastestMessage(state.chatId!, result.data!);
  }

  @override
  Future<void> close() {
    _chatDetailSubscription?.cancel();
    return super.close();
  }
}
