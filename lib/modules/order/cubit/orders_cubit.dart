import 'package:flutter/cupertino.dart';
import '../../../base/state.dart';
import '../data/order_repository.dart';
import '../model/order.dart';
import '../../../repositories/cart/cart_model.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/users/coordinate.dart';

import '../../../base/cubit.dart';
import '../../../repositories/result.dart';

part 'orders_state.dart';

class OrdersCubit extends FCubit<OrdersState> {
  OrdersCubit({
    required OrderRepository orderRepository,
    required FoodRepository foodRepository,
  })  : _orderRepository = orderRepository,
        _foodRepository = foodRepository,
        super(const OrdersState());

  final OrderRepository _orderRepository;
  final FoodRepository _foodRepository;

  void init() async {
    final orders = await fetchOrders();
    final foodIds = orders.map((e) => e.cart.items.keys.first).toList();

    final result = await _foodRepository.fetchFoodsByIds(foodIds);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state.copyWith(representativeFood: result.data!.toSet()));
  }

  void reset() {
    emitValue(state.copyWith(currentPage: 0));
  }

  void onPageChanged(int index, [PageController? controller]) async {
    if (index == state.currentPage) return;
    await controller?.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    emitValue(state.copyWith(currentPage: index));
  }

  void createOrder({
    required FCart cart,
    required double discount,
    required double deliveryCharge,
    required double subTotal,
    required Coordinate address,
  }) async {
    final newOrder = FOrder(
      address: address,
      cart: cart,
      created: DateTime.now(),
      discount: discount,
      deliveryCharge: deliveryCharge,
      subTotal: subTotal,
    );
    final List<FResult> responses = await Future.wait([
      _orderRepository.create(newOrder),
      _foodRepository.fetchFoodById(cart.items.keys.first),
    ]);

    for (var result in responses) {
      if (result.isError) {
        emitError(result.error!);
        return;
      }
    }

    emitValue(
      state.copyWith(
        processingOrders: [
          responses[0].data!,
          ...state.processingOrders,
        ],
        representativeFood: {responses[1].data!, ...state.representativeFood},
      ),
    );
  }

  Future<List<FOrder>> fetchOrders() async {
    try {
      List<FResult<List<FOrder>>> responses = await Future.wait(
        [
          _orderRepository.fetchOrdersByStatus(OrderStatus.processing),
          _orderRepository.fetchOrdersByStatus(OrderStatus.cancelled),
          _orderRepository.fetchOrdersByStatus(OrderStatus.delivered),
        ],
      );

      for (var result in responses) {
        if (result.isError) {
          emitError(result.error!);
          return const <FOrder>[];
        }
      }
      emit(
        state.copyWith(
          processingOrders: responses[0].data!,
          cancelledOrders: responses[1].data!,
          deliveredOrders: responses[2].data!,
        ),
      );

      final result = <FOrder>[];
      for (var e in responses) {
        result.addAll(e.data!);
      }
      return result;
    } catch (e) {
      emitError(e.runtimeType.toString());
      return const <FOrder>[];
    }
  }
}
