import 'package:cloud_firestore/cloud_firestore.dart';

import '../../base_collection_reference.dart';
import '../../result.dart';
import 'message_model.dart';
import 'message_repository.dart';

class MessageRepositoryImpl extends BaseCollectionReference<FMessage>
    implements MessageRepository {
  MessageRepositoryImpl()
      : super(
          FirebaseFirestore.instance
              .collection("messages")
              .withConverter<FMessage>(
                fromFirestore: (snapshot, _) =>
                    FMessage.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (message) => message.id!,
          setID: (message, id) => message.copyWith(id: id),
        );

  @override
  Future<FResult<List<FMessage>>> fetchMessages(String chatId,
      [FMessage? message, int limit = 10]) async {
    try {
      late QuerySnapshot<FMessage> querySnapshot;
      if (message == null) {
        querySnapshot = await ref
            .orderBy('timeStamp', descending: true)
            .where('chatId', isEqualTo: chatId)
            .limit(limit)
            .get();
      } else {
        final documentSnapshot =
            await ref.where('id', isEqualTo: message.id).get();
        querySnapshot = await ref
            .orderBy('timeStamp', descending: true)
            .where('chatId', isEqualTo: chatId)
            .startAfterDocument(documentSnapshot.docs.first)
            .limit(limit)
            .get();
      }
      return FResult.success(querySnapshot.docs.map((e) => e.data()).toList());
    } catch (e) {
      return FResult.exception(e);
    }
  }

  @override
  Future<FResult<FMessage>> sendMessage(FMessage message) {
    return add(message);
  }

  @override
  Stream<List<FMessage>> getStreamMessage(String chatId,
      [int limit = 10]) async* {
    await for (var snapshot in ref
        .orderBy('timeStamp', descending: true)
        .where('chatId', isEqualTo: chatId)
        .limit(limit)
        .snapshots()) {
      if (snapshot.docChanges.isEmpty) {
        yield const <FMessage>[];
        continue;
      }

      yield snapshot.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<FMessage?> getLastMessage(String chatId) async {
    final result = await fetchMessages(chatId, null, 1);
    if (result.isError) {
      throw result.error!;
    }

    if (result.data!.isEmpty) return null;

    return result.data!.first;
  }
}
