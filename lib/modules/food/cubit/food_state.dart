part of 'food_cubit.dart';

class FoodState extends FState {
  const FoodState({
    super.status,
    super.errorMessage,
    this.food,
    this.isAddedToCart = false,
    this.isAddToFavoriteList = false,
  });

  final FFood? food;
  final bool isAddedToCart;
  final bool isAddToFavoriteList;

  @override
  List<Object?> get props => [
        ...super.props,
        food,
        isAddedToCart,
        isAddToFavoriteList,
      ];

  @override
  FoodState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FFood? food,
    bool? isAddedToCart,
    bool? isAddToFavoriteList,
  }) {
    return FoodState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      food: food ?? this.food,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      isAddToFavoriteList: isAddToFavoriteList ?? this.isAddToFavoriteList,
    );
  }
}
