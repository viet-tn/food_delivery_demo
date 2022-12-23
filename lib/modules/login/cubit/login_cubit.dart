import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../constants/app_constants.dart';
import '../../../repositories/auth/auth_repository.dart';
import '../../../repositories/result.dart';
import '../../../repositories/users/user_model.dart';
import '../../../repositories/users/user_repository.dart';
import '../../../utils/services/shared_preferences.dart';
import '../../cubits/app/app_cubit.dart';
import '../../signup/cubit/sign_up_cubit.dart';
import '../models/email_input.dart';
import '../models/password_input.dart';

part 'login_state.dart';

class LoginCubit extends FCubit<LoginState> {
  LoginCubit({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required FSharedPreferences sharedPreferences,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _sharedPreferences = sharedPreferences,
        super(const LoginState());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final FSharedPreferences _sharedPreferences;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emitLoading();
    var result = await _authRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _loginHandler(result);
  }

  Future<void> loginWithGoogle() async {
    emitLoading();
    var result = await _authRepository.signInWithGoogle();
    _loginHandler(result);
  }

  Future<void> loginWithFacebook() async {
    emitLoading();
    var result = await _authRepository.signInWithFacebook();
    _loginHandler(result);
  }

  void _loginHandler(FResult<FUser> result) {
    if (result.isError) {
      return emitError(result.error!);
    }
  }

  void onCreateUserOnAuthenDbSuccess(FUser user) async {
    await _userRepository.set(user);
    emitValue(state.copyWith(user: user));
  }

  void onChangeEmail(String value) {
    emit(state.copyWith(email: EmailInput.dirty(value)));
  }

  void onChangePaswword(String value) =>
      emit(state.copyWith(password: PasswordInput.dirty(value)));

  Future<void> signOut() => _authRepository.signOut();

  Future<void> onOnboardingNextButtonPressed(PageController controller,
      void Function(bool isLastPage) onLastPageButtonPressed) async {
    final isLastPage = controller.page!.toInt() == onboardingContent.length - 1;
    if (isLastPage) {
      _sharedPreferences.setOnboardingValue(true);
      onLastPageButtonPressed(true);
    } else {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void init() {
    _authRepository.status.listen((status) {
      log(status.name);
      switch (status) {
        case AuthenStatus.authenticated:
          emitLoading();
          _authenticatedHandler();
          break;
        case AuthenStatus.unauthenticated:
          emitLoading();
          _unauthenticatedHandler();
          break;
      }
    });
  }

  void _unauthenticatedHandler() {
    emitValue(state.copyWith(user: FUser.empty));
  }

  void _authenticatedHandler() async {
    final currentUser = _authRepository.currentUser!;
    log(currentUser.email ?? 'email null');
    final dbUser = await fetchUserFromDB(currentUser.id);

    // Null means logined but not yet store user in firestore
    if (dbUser == null) {
      // Just add new user doc in firestore
      final setResult = await _userRepository.set(currentUser);

      if (setResult.isError) {
        return emitError(setResult.error!);
      }
      GetIt.I<AppCubit>().init(setResult.data!);
      _emitUser(setResult.data!);
      return;
    }

    GetIt.I<AppCubit>().init(dbUser);
    _emitUser(dbUser);
  }

  Future<FUser?> fetchUserFromDB(String id) async {
    final result = await _userRepository.get(id);
    if (result.isError) {
      return null;
    }

    return result.data;
  }

  void _emitUser(FUser user) {
    emitValue(state.copyWith(user: user));
    if (user.isSetupComplete) {
      return;
    }
    GetIt.I<SignUpCubit>().emitValue(
      GetIt.I<SignUpCubit>().state.copyWith(user: state.user),
    );
  }
}
