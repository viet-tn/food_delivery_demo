part of 'home_cubit.dart';

class HomeState extends FState {
  const HomeState({
    super.status,
    super.errorMessage,
    this.restaurants = const <FRestaurant>[],
    this.foods = const <FFood>[],
    this.hasNotification = false,
  });

  final List<FRestaurant> restaurants;
  final List<FFood> foods;
  final bool hasNotification;

  @override
  List<Object?> get props =>
      [...super.props, restaurants, foods, hasNotification];

  @override
  HomeState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    List<FRestaurant>? restaurants,
    List<FFood>? foods,
    bool? hasNotification,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      restaurants: restaurants ?? this.restaurants,
      foods: foods ?? this.foods,
      hasNotification: hasNotification ?? this.hasNotification,
    );
  }
}
