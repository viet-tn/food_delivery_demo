import '../../../../base/state.dart';
import '../../../../repositories/chat/messages/message_model.dart';

class ChatDetailState extends FState {
  const ChatDetailState({
    super.status,
    super.errorMessage,
    this.chatId,
    this.chatWithUserId,
    this.messages = const <FMessage>[],
  });

  final String? chatId;
  final String? chatWithUserId;
  final List<FMessage> messages;

  @override
  List<Object?> get props => [...super.props, chatId, chatWithUserId, messages];

  @override
  ChatDetailState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    String? chatId,
    String? chatWithUserId,
    List<FMessage>? messages,
  }) {
    return ChatDetailState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      chatId: chatId ?? this.chatId,
      chatWithUserId: chatWithUserId ?? this.chatWithUserId,
      messages: messages ?? this.messages,
    );
  }
}
