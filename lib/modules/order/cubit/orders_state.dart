part of 'orders_cubit.dart';

class OrdersState extends FState {
  const OrdersState({
    super.status,
    super.errorMessage,
    this.restaurants = const <FRestaurant>[],
    this.runningOrders = const <FOrder>[],
    this.historyOrders = const <FOrder>[],
    this.currentPage = 0,
    this.shipper,
  });

  final int currentPage;
  final List<FRestaurant> restaurants;
  final List<FOrder> runningOrders;
  final List<FOrder> historyOrders;
  final FUser? shipper;

  @override
  List<Object?> get props => [
        ...super.props,
        currentPage,
        restaurants,
        runningOrders,
        historyOrders,
        shipper,
      ];

  @override
  OrdersState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    int? currentPage,
    List<FRestaurant>? restaurants,
    List<FOrder>? runningOrders,
    List<FOrder>? historyOrders,
    FUser? shipper,
  }) {
    return OrdersState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      restaurants: restaurants ?? this.restaurants,
      runningOrders: runningOrders ?? this.runningOrders,
      historyOrders: historyOrders ?? this.historyOrders,
      shipper: shipper ?? this.shipper,
    );
  }
}
