import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/async_state.dart';
import '../../../repositories/notification/notification.dart';
import '../../../repositories/notification/notification_repository.dart';

part 'notification_cubit.freezed.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._notificationRepository)
      : super(const NotificationState());

  final NotificationRepository _notificationRepository;

  void fetchFirstNotificationBatch(String uid) async {
    final result = await _notificationRepository.fetch(uid);

    if (result.isError) {
      emit(state.copyWith(notifications: AsyncState.error(result.error!)));
      return;
    }

    final notifications = result.data!;

    if (notifications.isEmpty) {
      emit(state.copyWith(notifications: const AsyncState.empty()));
      return;
    }

    emit(state.copyWith(notifications: AsyncState.data(notifications)));
  }
}
