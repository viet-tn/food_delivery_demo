part of 'app_cubit.dart';

class AppState extends FState {
  const AppState({
    super.status,
    super.errorMessage,
    this.user,
    this.favoriteList,
    this.favoriteFoodList = const <FFood>[],
  });

  final FUser? user;
  final FFavoriteList? favoriteList;
  final List<FFood> favoriteFoodList;

  @override
  List<Object?> get props => [
        ...super.props,
        user,
        favoriteList,
        favoriteFoodList,
      ];

  @override
  AppState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FUser? user,
    FFavoriteList? favoriteList,
    List<FFood>? favoriteFoodList,
  }) {
    return AppState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      favoriteList: favoriteList ?? this.favoriteList,
      favoriteFoodList: favoriteFoodList ?? this.favoriteFoodList,
    );
  }
}
