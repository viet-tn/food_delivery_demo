part of 'order_details_cubit.dart';

@freezed
class OrderDetailsState with _$OrderDetailsState {
  const factory OrderDetailsState.loading() = _Loading;
  const factory OrderDetailsState.loadFailure(String message) = _LoadFailure;
  const factory OrderDetailsState.loadSuccess(
    FOrder order,
    List<FFood> foods,
    FRestaurant restaurant,
  ) = _LoadSuccess;
}
