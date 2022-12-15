import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'messages/message_model.dart';

class FChat extends Equatable {
  const FChat({
    this.id,
    required this.userIds,
    this.lastestMessage,
    required this.created,
  });

  final String? id;
  final List<String> userIds;
  final FMessage? lastestMessage;
  final DateTime created;

  @override
  List<Object?> get props => [id, userIds, lastestMessage];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userIds': userIds,
      'lastestMessage': lastestMessage?.toMap(),
      'created': created,
    };
  }

  factory FChat.fromMap(Map<String, dynamic> map) {
    return FChat(
      id: map['id'],
      userIds: List<String>.from((map['userIds'])),
      lastestMessage: map['lastestMessage'] == null
          ? null
          : FMessage.fromMap(map['lastestMessage']),
      created: map['created'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FChat.fromJson(String source) =>
      FChat.fromMap(json.decode(source) as Map<String, dynamic>);

  FChat copyWith({
    String? id,
    List<String>? userIds,
    FMessage? lastestMessage,
    DateTime? created,
  }) {
    return FChat(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
      lastestMessage: lastestMessage ?? this.lastestMessage,
      created: created ?? this.created,
    );
  }
}
