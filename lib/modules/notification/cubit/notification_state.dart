part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(AsyncState.loading())
        AsyncState<List<FNotification>> notifications,
  }) = _NotificationState;
}
