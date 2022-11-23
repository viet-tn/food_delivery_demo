import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

abstract class FCubit<T extends FState> extends Cubit<T> {
  FCubit(super.initialState);

  void emitError(String errorMessage) {
    if (isClosed) {
      return;
    }
    emit(
      state.copyWith(
        status: ScreenStatus.error,
        errorMessage: errorMessage,
      ) as T,
    );
  }

  void emitValue([T? state]) {
    if (isClosed) {
      return;
    }

    if (state == null) {
      emit(this.state.copyWith(status: ScreenStatus.value) as T);
      return;
    }

    emit(
      state.copyWith(status: ScreenStatus.value) as T,
    );
  }

  void emitLoading() {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(status: ScreenStatus.loading) as T);
  }

  @override
  void emit(T? state) {
    if (isClosed) {
      return;
    }
    super.emit(state as T);
  }
}
