part of 'app_cubit.dart';

class AppState extends FState {
  const AppState({
    super.status,
    super.errorMessage,
    this.user,
    this.order,
    this.restaurant,
    this.shipper,
  });

  final FUser? user;
  final FOrder? order;
  final FRestaurant? restaurant;
  final FUser? shipper;

  @override
  List<Object?> get props => [
        ...super.props,
        user,
        order,
        restaurant,
        shipper,
      ];

  @override
  AppState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FUser? user,
    FOrder? order,
    FRestaurant? restaurant,
    FUser? shipper,
  }) {
    return AppState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      order: order ?? this.order,
      restaurant: restaurant ?? this.restaurant,
      shipper: shipper ?? this.shipper,
    );
  }
}
