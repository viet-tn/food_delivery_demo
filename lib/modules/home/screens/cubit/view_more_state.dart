part of 'view_more_cubit.dart';

@freezed
class ViewMoreState extends Equatable with _$ViewMoreState {
  const ViewMoreState._();
  const factory ViewMoreState({
    @Default(AsyncState.loading()) AsyncState<List<FRestaurant>> restaurants,
    @Default(AsyncState.loading()) AsyncState<List<FFood>> foods,
  }) = _ViewMoreState;

  @override
  List<Object?> get props => [restaurants, foods];
}
