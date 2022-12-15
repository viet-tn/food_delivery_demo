import 'dart:async';

import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/chat/chat_model.dart';
import '../../../repositories/chat/chat_repository.dart';
import '../../../repositories/chat/messages/message_model.dart';
import '../../../repositories/users/user_repository.dart';
import '../../login/cubit/login_cubit.dart';

part 'chat_state.dart';

class ChatCubit extends FCubit<ChatState> {
  ChatCubit({
    required ChatRepository chatRepository,
    required UserRepository userRepository,
  })  : _chatRepository = chatRepository,
        _userRepository = userRepository,
        super(const ChatState());

  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  StreamSubscription? _chatSubscription;

  void init(String userId) {
    _chatSubscription?.cancel();

    _chatSubscription = _chatRepository.getStreamChat(userId).listen(
      (event) {
        emitValue(
          state.copyWith(
            chats: event.toList()
              ..sort(
                (a, b) => a.created.compareTo(b.created),
              ),
          ),
        );
      },
    );
  }

  Future<void> createChat(String userId) async {
    emitLoading();

    final shipperResult = await _userRepository.getShipper();

    if (shipperResult.isError) {
      emitError(shipperResult.error!);
      return;
    }

    final result = await _chatRepository.createChat(
      FChat(
        userIds: [userId, shipperResult.data!.id],
        created: DateTime.now(),
      ),
    );
    if (result.isError) {
      emitError(result.error!);
      return;
    }
    init(userId);
  }

  void fetchChats(String userId) async {
    final result = await _chatRepository.fetchChats(userId);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state.copyWith(chats: result.data!));
  }

  void readMessage(String chatId, FMessage? message) {
    if (message == null) return;
    if (message.senderId == GetIt.I<LoginCubit>().state.user.id) return;

    final update = message.copyWith(isSeen: true);

    _chatRepository.updateLastestMessage(chatId, update);
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}
