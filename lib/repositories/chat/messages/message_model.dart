import 'dart:convert';

import 'package:equatable/equatable.dart';

class FMessage extends Equatable {
  const FMessage({
    this.id,
    required this.chatId,
    required this.senderId,
    required this.timeStamp,
    required this.content,
    this.isSeen = false,
  });
  final String? id;
  final String chatId;
  final String senderId;

  /// MilisecondSinceEpoch
  final int timeStamp;
  final String content;
  final bool isSeen;

  @override
  List<Object?> get props => [id, chatId, senderId, timeStamp, content, isSeen];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chatId': chatId,
      'senderId': senderId,
      'timeStamp': timeStamp,
      'content': content,
      'isSeen': isSeen,
    };
  }

  factory FMessage.fromMap(Map<String, dynamic> map) {
    return FMessage(
      id: map['id'],
      chatId: map['chatId'],
      senderId: map['senderId'],
      timeStamp: map['timeStamp'],
      content: map['content'],
      isSeen: map['isSeen'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FMessage.fromJson(String source) =>
      FMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  FMessage copyWith({
    String? id,
    String? chatId,
    String? senderId,
    int? timeStamp,
    String? content,
    bool? isSeen,
  }) {
    return FMessage(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      timeStamp: timeStamp ?? this.timeStamp,
      content: content ?? this.content,
      isSeen: isSeen ?? this.isSeen,
    );
  }
}
