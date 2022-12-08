part of 'orders_cubit.dart';

class OrdersState extends FState {
  const OrdersState({
    super.status,
    super.errorMessage,
    this.currentPage = 0,
    this.representativeFood = const <FFood>{},
    this.processingOrders = const <FOrder>[],
    this.deliveredOrders = const <FOrder>[],
    this.cancelledOrders = const <FOrder>[],
  });

  final int currentPage;
  final Set<FFood> representativeFood;
  final List<FOrder> processingOrders;
  final List<FOrder> deliveredOrders;
  final List<FOrder> cancelledOrders;

  @override
  List<Object?> get props => [
        ...super.props,
        currentPage,
        representativeFood,
        processingOrders,
        deliveredOrders,
        cancelledOrders,
      ];

  @override
  OrdersState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    int? currentPage,
    Set<FFood>? representativeFood,
    List<FOrder>? processingOrders,
    List<FOrder>? deliveredOrders,
    List<FOrder>? cancelledOrders,
  }) {
    return OrdersState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      representativeFood: representativeFood ?? this.representativeFood,
      processingOrders: processingOrders ?? this.processingOrders,
      deliveredOrders: deliveredOrders ?? this.deliveredOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
    );
  }
}
