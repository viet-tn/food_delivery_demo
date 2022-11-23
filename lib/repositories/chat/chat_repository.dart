import '../result.dart';
import 'chat_model.dart';
import 'messages/message_model.dart';

abstract class ChatRepository {
  Future<FResult<List<FChat>>> fetchChats(String userId,
      [FChat? chat, int limit = 10]);

  Future<FResult<FChat>> createChat(FChat chat);

  Stream<List<FChat>> getStreamChat(String userId);

  Future<FResult<FChat>> updateLastestMessage(String chatId, FMessage message);
}
