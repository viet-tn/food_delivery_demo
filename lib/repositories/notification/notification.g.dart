// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FNotification _$$_FNotificationFromJson(Map<String, dynamic> json) =>
    _$_FNotification(
      id: json['id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      uid: json['uid'] as String,
      orderId: json['orderId'] as String,
      created: const TimestampConverter().fromJson(json['created']),
    );

Map<String, dynamic> _$$_FNotificationToJson(_$_FNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'uid': instance.uid,
      'orderId': instance.orderId,
      'created': const TimestampConverter().toJson(instance.created),
    };
