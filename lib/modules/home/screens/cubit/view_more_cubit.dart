import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../base/async_state.dart';
import '../../../../repositories/food/food_model.dart';
import '../../../../repositories/food/food_repository.dart';
import '../../../../repositories/maps/search/places_search_repository.dart';
import '../../../../repositories/restaurants/restaurant_model.dart';
import '../../../../repositories/restaurants/restaurant_repository.dart';
import '../../../../repositories/result.dart';
import '../../../../repositories/users/coordinate.dart';

part 'view_more_state.dart';
part 'view_more_cubit.freezed.dart';

class ViewMoreCubit extends Cubit<ViewMoreState> {
  ViewMoreCubit(
    this._foodRepository,
    this._restaurantRepository,
    this._placesSearchRepository,
  ) : super(const ViewMoreState());

  final FoodRepository _foodRepository;
  final RestaurantRepository _restaurantRepository;
  final PlacesSearchRepository _placesSearchRepository;

  void initViewMoreRestaurant(
    List<FRestaurant> restaurants,
    Coordinate currentPosition,
  ) {
    emit(state.copyWith(restaurants: AsyncState.data(restaurants)));
    fetchNextNearestRestaurantBatch(currentPosition);
  }

  void initViewMoreFood(List<FFood> foods) {
    emit(state.copyWith(foods: AsyncState.data(foods)));
  }

  void fetchNextNearestRestaurantBatch(Coordinate currentPosition) async {
    state.restaurants.whenOrNull(
      data: (restaurants) async {
        log('fetchNextNearestRestaurantBatch');
        emit(state.copyWith(restaurants: AsyncState.loading(restaurants)));
        await Future.delayed(const Duration(seconds: 1));

        final result = await _restaurantRepository.fetchNearestRestaurants(
          currentPosition.latitude,
          currentPosition.longitude,
          restaurants.last,
        );

        if (result.isError) {
          emit(state.copyWith(
            restaurants: AsyncState.error(
              result.error!,
              restaurants,
            ),
          ));
          return;
        }

        final newRestaurants = result.data!;

        if (newRestaurants.isEmpty) {
          emit(state.copyWith(restaurants: AsyncState.empty(restaurants)));
          return;
        }

        final update =
            await _updateDurationAndEmitValue(newRestaurants, currentPosition);
        emit(
          state.copyWith(
            restaurants: AsyncState.data([
              ...restaurants,
              ...update
                ..sort(
                  (a, b) =>
                      a.coordinate.geohash!.compareTo(b.coordinate.geohash!),
                )
            ]),
          ),
        );
      },
    );
  }

  Future<List<FRestaurant>> _updateDurationAndEmitValue(
      List<FRestaurant> restaurants, Coordinate coordinate) async {
    final update = <FRestaurant>[];
    await Future.wait(restaurants.map((restaurant) async {
      final matrix = await _placesSearchRepository.calculateDistance(
        restaurant.coordinate.latitude,
        restaurant.coordinate.longitude,
        coordinate.latitude,
        coordinate.longitude,
      );
      return update.add(restaurant.copyWith(
        distance: matrix[0],
        duration: matrix[1],
      ));
    }));
    return update;
  }

  void fetchNextPopularFoodBatch() async {
    state.foods.whenOrNull(
      data: (foods) async {
        emit(state.copyWith(foods: AsyncState.loading(foods)));
        await Future.delayed(const Duration(seconds: 1));
        final result = await _foodRepository.fetchPopularFoods(foods.last);

        _fetchFoodHandler(result, foods);
      },
    );
  }

  void fetchNextRestaurantFoodBatch(
    List<String> foodIds,
  ) async {
    state.foods.whenOrNull(
      data: (foods) async {
        emit(state.copyWith(foods: AsyncState.loading(foods)));
        await Future.delayed(const Duration(seconds: 1));
        final result =
            await _foodRepository.fetchFoodsByIds(foodIds, foods.last);

        _fetchFoodHandler(result, foods);
      },
    );
  }

  void _fetchFoodHandler(FResult<List<FFood>> result, List<FFood> foods) {
    if (result.isError) {
      emit(state.copyWith(
        foods: AsyncState.error(
          result.error!,
          foods,
        ),
      ));
      return;
    }

    final newFoods = result.data!;

    if (newFoods.isEmpty) {
      emit(state.copyWith(foods: AsyncState.empty(foods)));
      return;
    }

    emit(
      state.copyWith(
        foods: AsyncState.data([...foods, ...newFoods]),
      ),
    );
  }

  @override
  Future<void> close() {
    log('viewMoreCubit closed');
    return super.close();
  }
}
