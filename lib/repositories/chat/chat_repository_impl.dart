import 'package:cloud_firestore/cloud_firestore.dart';

import '../base_collection_reference.dart';
import '../result.dart';
import 'chat_model.dart';
import 'chat_repository.dart';
import 'messages/message_model.dart';

class ChatRepositoryImpl extends BaseCollectionReference<FChat>
    implements ChatRepository {
  ChatRepositoryImpl()
      : super(
          FirebaseFirestore.instance.collection("chats").withConverter<FChat>(
                fromFirestore: (snapshot, _) => FChat.fromMap(snapshot.data()!),
                toFirestore: (value, _) => value.toMap(),
              ),
          getID: (chat) => chat.id!,
          setID: (chat, id) => chat.copyWith(id: id),
        );

  @override
  Future<FResult<List<FChat>>> fetchChats(String userId,
      [FChat? chat, int limit = 10]) async {
    try {
      late QuerySnapshot<FChat> querySnapshot;
      if (chat == null) {
        querySnapshot = await ref
            .where('userIds', arrayContains: userId)
            .limit(limit)
            .get();
      } else {
        final documentSnapshot =
            await ref.where('id', isEqualTo: chat.id).get();
        querySnapshot = await ref
            .where('userIds', arrayContains: userId)
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
  Future<FResult<FChat>> createChat(FChat chat) async {
    return super.add(chat);
  }

  @override
  Stream<List<FChat>> getStreamChat(String userId) async* {
    await for (var snapshot in ref
        .where('userIds', arrayContains: userId)
        .orderBy('created', descending: true)
        .snapshots()) {
      if (snapshot.docs.isEmpty) {
        yield const <FChat>[];
        continue;
      }

      yield snapshot.docs.map((e) => e.data()).toList();
    }
  }

  @override
  Future<FResult<FChat>> updateLastestMessage(
      String chatId, FMessage message) async {
    try {
      final documentSnapshot = await ref.doc(chatId).get();

      if (!documentSnapshot.exists) return FResult.error('Chat Not Found');

      final update = documentSnapshot.data()!.copyWith(lastestMessage: message);

      await ref.doc(chatId).update(update.toMap());
      return FResult.success(update);
    } catch (e) {
      return FResult.exception(e);
    }
  }
}
