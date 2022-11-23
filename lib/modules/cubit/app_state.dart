part of 'app_cubit.dart';

class AppState extends FState {
  const AppState({
    super.status,
    super.errorMessage,
    this.user,
    this.favoriteList,
    this.cart,
    this.favoriteFoodList = const <FFood>[],
    this.cartFoodList = const <FFood>[],
  });

  final FUser? user;
  final FFavoriteList? favoriteList;
  final FCart? cart;
  final List<FFood> favoriteFoodList;
  final List<FFood> cartFoodList;

  @override
  List<Object?> get props => [
        ...super.props,
        favoriteList,
        cart,
        favoriteFoodList,
        cartFoodList,
      ];

  @override
  AppState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FUser? user,
    FFavoriteList? favoriteList,
    FCart? cart,
    List<FFood>? favoriteFoodList,
    List<FFood>? cartFoodList,
  }) {
    return AppState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      favoriteList: favoriteList ?? this.favoriteList,
      cart: cart ?? this.cart,
      favoriteFoodList: favoriteFoodList ?? this.favoriteFoodList,
      cartFoodList: cartFoodList ?? this.cartFoodList,
    );
  }
}
