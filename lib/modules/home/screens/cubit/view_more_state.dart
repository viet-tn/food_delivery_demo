part of 'view_more_cubit.dart';

class ViewMoreState extends FState {
  const ViewMoreState({
    super.status,
    super.errorMessage,
    this.foods,
    this.restaurants,
  });

  final List<FFood>? foods;
  final List<FRestaurant>? restaurants;

  @override
  List<Object?> get props => [
        ...super.props,
        foods,
        restaurants,
      ];

  @override
  ViewMoreState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    List<FFood>? foods,
    List<FRestaurant>? restaurants,
  }) =>
      ViewMoreState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        foods: foods ?? this.foods,
        restaurants: restaurants ?? this.restaurants,
      );
}
