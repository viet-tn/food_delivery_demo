import '../../result.dart';
import 'message_model.dart';

abstract class MessageRepository {
  Stream<List<FMessage>> getStreamMessage(String chatId);

  Future<FResult<List<FMessage>>> fetchMessages(String chatId,
      [FMessage? message, int limit = 10]);

  Future<FResult<FMessage>> sendMessage(FMessage message);

  Future<FMessage?> getLastMessage(String chatId);
}
