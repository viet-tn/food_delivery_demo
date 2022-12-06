part of 'favorite_cubit.dart';

class FavoriteState extends FState {
  const FavoriteState({
    super.status,
    super.errorMessage,
    this.favoriteList,
    this.foods = const <FFood>[],
  });

  final FFavoriteList? favoriteList;
  final List<FFood> foods;

  @override
  List<Object?> get props => [
        ...super.props,
        favoriteList,
        foods,
      ];

  @override
  FavoriteState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FFavoriteList? favoriteList,
    List<FFood>? foods,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      favoriteList: favoriteList ?? this.favoriteList,
      foods: foods ?? this.foods,
    );
  }
}
