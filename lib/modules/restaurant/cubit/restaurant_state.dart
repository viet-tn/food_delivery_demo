part of 'restaurant_cubit.dart';

class RestaurantState extends FState {
  const RestaurantState({
    super.status,
    super.errorMessage,
    this.restaurant,
    this.foods = const <FFood>[],
  });

  final FRestaurant? restaurant;
  final List<FFood> foods;

  @override
  List<Object?> get props => [...super.props, restaurant, foods];

  @override
  RestaurantState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FRestaurant? restaurant,
    List<FFood>? foods,
  }) {
    return RestaurantState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurant: restaurant ?? this.restaurant,
      foods: foods ?? this.foods,
    );
  }
}
