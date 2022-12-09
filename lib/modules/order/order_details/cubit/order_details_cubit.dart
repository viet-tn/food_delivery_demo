import '../../../../base/state.dart';
import '../../model/order.dart';
import '../../../../repositories/food/food_model.dart';
import '../../../../repositories/food/food_repository.dart';

import '../../../../base/cubit.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends FCubit<OrderDetailsState> {
  OrderDetailsCubit({
    required FoodRepository foodRepository,
  })  : _foodRepository = foodRepository,
        super(const OrderDetailsState());

  final FoodRepository _foodRepository;

  void init(FOrder order) async {
    final result =
        await _foodRepository.fetchFoodsByIds(order.cart.items.keys.toList());

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(state.copyWith(
      order: order,
      foods: result.data!,
    ));
  }
}
