import '../result.dart';
import 'food_model.dart';

abstract class FoodRepository {
  Future<FResult<List<FFood>>> fetchFoods([FFood? food, int limit = 10]);

  Future<FResult<FFood?>> fetchFoodById(String foodId);

  Future<FResult<List<FFood>>> fetchFoodsByIds(List<String> foodIds);

  Future<FResult<List<FFood>>> fetchPopularFoods([FFood? food, int limit = 10]);
}
