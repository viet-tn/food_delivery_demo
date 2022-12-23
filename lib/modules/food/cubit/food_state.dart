part of 'food_cubit.dart';

class FoodState extends FState {
  const FoodState({
    super.status,
    super.errorMessage,
    this.food,
    this.isAddToFavoriteList = false,
  });

  final FFood? food;
  final bool isAddToFavoriteList;

  @override
  List<Object?> get props => [
        ...super.props,
        food,
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
      isAddToFavoriteList: isAddToFavoriteList ?? this.isAddToFavoriteList,
    );
  }
}
