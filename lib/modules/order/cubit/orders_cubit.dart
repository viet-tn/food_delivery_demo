import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../repositories/restaurants/restaurant_model.dart';
import '../../../repositories/restaurants/restaurant_repository.dart';
import '../../../repositories/result.dart';
import '../../../repositories/users/user_model.dart';
import '../../../repositories/users/user_repository.dart';
import '../data/order_repository.dart';
import '../model/order.dart';

part 'orders_state.dart';

class OrdersCubit extends FCubit<OrdersState> {
  OrdersCubit({
    required RestaurantRepository restaurantRepository,
    required UserRepository userRepository,
  })  : _restaurantRepository = restaurantRepository,
        _userRepository = userRepository,
        super(const OrdersState());

  final RestaurantRepository _restaurantRepository;
  final UserRepository _userRepository;

  void fetchNew() async {
    emitLoading();
    final ordersResult = await GetIt.I<OrderRepository>().fetchAllOrders();

    if (ordersResult.isError) {
      emitError(ordersResult.error!);
      return;
    }

    final orders = ordersResult.data!;

    List<FResult<FRestaurant>>? responses = await Future.wait([
      ...orders.map((e) => _restaurantRepository.getById(e.cart.restaurantId!)),
    ]);

    for (var response in responses) {
      if (response.isError) {
        emitError(response.error!);
        return;
      }
    }

    List<FRestaurant> restaurants = responses.map((e) => e.data!).toList();
    final runningOrders = orders.where((order) => order.isRunning).toList();
    final historyOrders = orders.where((order) => !order.isRunning).toList();

    FUser? shipper;
    if (runningOrders.isNotEmpty) {
      final result = await _userRepository.getShipper();
      if (result.isError) {
        emitError(result.error!);
        return;
      }
      shipper = result.data!;
    }

    emitValue(
      state.copyWith(
        restaurants: restaurants,
        runningOrders: runningOrders,
        historyOrders: historyOrders,
        shipper: shipper,
      ),
    );
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
      GetIt.I<OrderRepository>().create(newOrder),
      _restaurantRepository.getById(newOrder.cart.restaurantId!),
    ]);

    for (var result in responses) {
      if (result.isError) {
        emitError(result.error!);
        return;
      }
    }

    final order = responses[0] as FOrder;
    final restaurant = responses[1] as FRestaurant;

    emitValue(
      state.copyWith(
        runningOrders: [...state.runningOrders, order],
        restaurants: [...state.restaurants, restaurant],
      ),
    );
  }

  void onOrderCancelledOrDelivered(FOrder update,
      {required void Function() onUpdateSucceeded}) async {
    final result = await GetIt.I<OrderRepository>().set(update);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        runningOrders: state.runningOrders.toList()
          ..removeWhere((order) => order.id == update.id),
        historyOrders: [update, ...state.historyOrders],
      ),
    );
  }
}
