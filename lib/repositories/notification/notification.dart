import 'package:equatable/equatable.dart';
import '../../utils/converters/time_stamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class FNotification extends Equatable with _$FNotification {
  const FNotification._();
  const factory FNotification({
    String? id,
    required String title,
    required String body,
    required String uid,
    required String orderId,
    @TimestampConverter() required DateTime created,
  }) = _FNotification;

  factory FNotification.fromJson(Map<String, Object?> json) =>
      _$FNotificationFromJson(json);

  @override
  List<Object?> get props => [id, title, body, uid, orderId, created];
}
