part of 'food_cubit.dart';

class FoodState extends FState {
  const FoodState({
    super.status,
    super.errorMessage,
    this.food,
  });

  final FFood? food;

  @override
  List<Object?> get props => [
        ...super.props,
        food,
      ];

  @override
  FoodState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FFood? food,
    bool? isAddedToCart,
  }) {
    return FoodState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      food: food ?? this.food,
    );
  }
}
