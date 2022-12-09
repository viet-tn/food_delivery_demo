part of 'order_details_cubit.dart';

class OrderDetailsState extends FState {
  const OrderDetailsState({
    super.status,
    super.errorMessage,
    this.order,
    this.foods,
  });

  final FOrder? order;
  final List<FFood>? foods;

  @override
  List<Object?> get props => [
        ...super.props,
        foods,
      ];

  @override
  OrderDetailsState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    FOrder? order,
    List<FFood>? foods,
  }) {
    return OrderDetailsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      order: order ?? this.order,
      foods: foods ?? this.foods,
    );
  }
}
