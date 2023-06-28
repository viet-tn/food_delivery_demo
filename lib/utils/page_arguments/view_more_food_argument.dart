import '../../modules/home/screens/cubit/view_more_cubit.dart';
import '../../repositories/food/food_model.dart';

class ViewMoreFoodsArgument {
  const ViewMoreFoodsArgument({
    required this.cubit,
    required this.title,
    required this.foods,
    required this.onFetchMoreItems,
  });

  final ViewMoreCubit cubit;
  final String title;
  final List<FFood> foods;
  final void Function() onFetchMoreItems;
}
