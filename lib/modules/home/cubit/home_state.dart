part of 'home_cubit.dart';

class HomeState extends FState {
  const HomeState({
    super.status,
    super.errorMessage,
    this.restaurants = const <FRestaurant>[],
    this.foods = const <FFood>[],
  });

  final List<FRestaurant> restaurants;
  final List<FFood> foods;

  @override
  List<Object?> get props => [...super.props, restaurants, foods];

  @override
  HomeState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    List<FRestaurant>? restaurants,
    List<FFood>? foods,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurants: restaurants ?? this.restaurants,
      foods: foods ?? this.foods,
    );
  }
}
