import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/food/food_repository.dart';
import '../../../repositories/result.dart';
import '../../cubits/app/app_cubit.dart';
import '../data/order_repository.dart';
import '../model/order.dart';

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
    controller?.jumpToPage(
      index,
    );
    emitValue(state.copyWith(currentPage: index));
  }

  void createOrder({required FOrder newOrder}) async {
    final List<FResult> responses = await Future.wait([
      _orderRepository.create(newOrder),
      _foodRepository.fetchFoodById(newOrder.cart.items.keys.first),
    ]);

    for (var result in responses) {
      if (result.isError) {
        emitError(result.error!);
        return;
      }
    }

    GetIt.I<AppCubit>().getProcessingOrderInfo(responses[0].data!);

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

  void onOrderDelivered(FOrder update) async {
    final result = await _orderRepository.set(update);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        processingOrders: state.processingOrders.toList()
          ..removeWhere((order) => order.id == update.id),
        deliveredOrders: [update, ...state.deliveredOrders],
      ),
    );
  }

  void cancelOrder(FOrder processingOrder,
      {required void Function() onCancelSucceeded}) async {
    final update = processingOrder.copyWith(status: OrderStatus.cancelled);
    final result = await _orderRepository.set(update);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    onCancelSucceeded();

    emitValue(
      state.copyWith(
        processingOrders: state.processingOrders.toList()
          ..removeWhere((order) => order.id == update.id),
        cancelledOrders: [update, ...state.cancelledOrders],
      ),
    );
  }
}
