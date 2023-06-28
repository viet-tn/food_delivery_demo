import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../modules/login/cubit/login_cubit.dart';

class UserRefreshStream extends ChangeNotifier {
  UserRefreshStream(LoginCubit cubit) {
    LoginState oldState = cubit.state;
    _subscription = cubit.stream.listen(
      (LoginState currentState) {
        if (currentState.status.isLoading || currentState.status.hasError) {
          return;
        }
        if (oldState.user.id != currentState.user.id) {
          notifyListeners();
          oldState = currentState;
          return;
        }

        if (!oldState.user.isSetupComplete &&
            currentState.user.isSetupComplete) {
          notifyListeners();
          oldState = currentState;
          return;
        }
        oldState = currentState;
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
