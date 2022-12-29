import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../repositories/food/food_model.dart';
import '../../../../repositories/food/food_repository.dart';
import '../../../../repositories/maps/search/places_search_repository.dart';
import '../../../../repositories/restaurants/restaurant_model.dart';
import '../../../../repositories/restaurants/restaurant_repository.dart';
import '../../data/order_repository.dart';
import '../../model/order.dart';

part 'order_details_cubit.freezed.dart';
part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit(
    this._placesSearchRepository,
    this._restaurantRepository,
    this._foodRepository,
    this._orderRepository,
  ) : super(const OrderDetailsState.loading());

  final PlacesSearchRepository _placesSearchRepository;
  final RestaurantRepository _restaurantRepository;
  final FoodRepository _foodRepository;
  final OrderRepository _orderRepository;

  void init(FOrder order) async {
    final restaurantResult =
        await _restaurantRepository.getById(order.cart.restaurantId!);

    if (restaurantResult.isError) {
      emit(OrderDetailsState.loadFailure(restaurantResult.error!));
      return;
    }

    final restaurant = restaurantResult.data!;

    final foodsResult =
        await _foodRepository.fetchFoodsByIds(order.cart.items.keys.toList());

    if (foodsResult.isError) {
      emit(OrderDetailsState.loadFailure(foodsResult.error!));
      return;
    }

    try {
      final matrix = await _placesSearchRepository.calculateDistance(
        restaurant.coordinate.latitude,
        restaurant.coordinate.longitude,
        order.userPosition.latitude,
        order.userPosition.longitude,
      );

      final restaurantUpdate =
          restaurant.copyWith(distance: matrix[0], duration: matrix[1]);
      emit(
        OrderDetailsState.loadSuccess(
          order,
          foodsResult.data!,
          restaurantUpdate,
        ),
      );
    } catch (e) {
      emit(OrderDetailsState.loadFailure(e.runtimeType.toString()));
    }
  }

  void cancelOrder({required void Function() onOrderUpdated}) {
    _updateOrderStatus(OrderStatus.cancelled, onOrderUpdated);
  }

  void _updateOrderStatus(OrderStatus status, void Function() onOrderUpdated) {
    state.whenOrNull(
      loadSuccess: (order, foods, restaurant) async {
        final update = order.copyWith(status: status);
        final result = await _orderRepository.set(update);

        if (result.isError) {
          return;
        }

        onOrderUpdated();

        emit(
          OrderDetailsState.loadSuccess(
            update,
            foods,
            restaurant,
          ),
        );
      },
    );
  }

  //* Function for simulation
  void onNextStatus({required void Function() onOrderUpdated}) {
    state.whenOrNull(
      loadSuccess: (order, foods, restaurant) {
        if (order.status == OrderStatus.placed) {
          _updateOrderStatus(OrderStatus.confirmed, onOrderUpdated);
        }
        if (order.status == OrderStatus.confirmed) {
          _updateOrderStatus(OrderStatus.preparing, onOrderUpdated);
        }
        if (order.status == OrderStatus.preparing) {
          _updateOrderStatus(OrderStatus.onTheWay, onOrderUpdated);
        }
        if (order.status == OrderStatus.onTheWay) {
          _updateOrderStatus(OrderStatus.delivered, onOrderUpdated);
        }
      },
    );
  }
}
