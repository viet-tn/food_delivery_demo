part of 'chat_cubit.dart';

class ChatState extends FState {
  const ChatState({
    super.status,
    super.errorMessage,
    this.chats = const <FChat>[],
  });

  final List<FChat> chats;

  @override
  List<Object?> get props => [...super.props, chats];

  @override
  ChatState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    List<FChat>? chats,
  }) {
    return ChatState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      chats: chats ?? this.chats,
    );
  }
}
