import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/async_state.dart';
import '../../../repositories/food/food_model.dart';
import '../../../repositories/rating/rating.dart';
import '../../../repositories/rating/rating_repository.dart';
import '../../../repositories/rating/star/star.dart';
import '../../../repositories/rating/star/star_count_repository.dart';
import '../../../repositories/restaurants/restaurant_repository.dart';

part 'food_cubit.freezed.dart';
part 'food_state.dart';

class FoodCubit extends Cubit<FoodState> {
  FoodCubit(
    this._ratingRepository,
    this._starCountRepository,
    this._restaurantRepository,
  ) : super(const FoodState());

  final StarCountRepository _starCountRepository;
  final RatingRepository _ratingRepository;
  final RestaurantRepository _restaurantRepository;

  void init(FFood food) async {
    emit(state.copyWith(food: AsyncState.data(food)));

    fetchStar(food.id);
    fetchFirstReviewBatch(food.id);
  }

  void fetchStar(String foodId) async {
    emit(state.copyWith(star: const AsyncState.loading()));

    final restaurantResult = await _restaurantRepository.getByFoodId(foodId);

    if (restaurantResult.isError) {
      emit(state.copyWith(star: AsyncState.error(restaurantResult.error!)));
      return;
    }

    final result = await _starCountRepository.getFoodStar(
      restaurantResult.data!.id,
      foodId,
    );
    if (result.isError) {
      emit(state.copyWith(star: AsyncState.error(result.error!)));
      return;
    }

    emit(state.copyWith(star: AsyncState.data(result.data!)));
  }

  void fetchFirstReviewBatch(String foodId) async {
    emit(state.copyWith(ratings: const AsyncState.loading()));

    final result = await _ratingRepository.fetchRatingsByFoodId(foodId);

    if (result.isError) {
      emit(state.copyWith(ratings: AsyncState.error(result.error!)));
      return;
    }

    final reviews = result.data!;

    if (reviews.isEmpty) {
      emit(state.copyWith(ratings: const AsyncState.empty()));
      return;
    }

    emit(state.copyWith(ratings: AsyncState.data(result.data!)));
  }
}
