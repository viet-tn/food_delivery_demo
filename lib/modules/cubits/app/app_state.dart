part of 'app_cubit.dart';

class AppState extends FState {
  const AppState({
    super.status,
    super.errorMessage,
    this.user,
  });

  final FUser? user;

  @override
  List<Object?> get props => [
        ...super.props,
        user,
      ];

  @override
  AppState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FUser? user,
  }) {
    return AppState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }
}
