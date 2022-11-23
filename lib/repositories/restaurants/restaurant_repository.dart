import '../result.dart';
import 'restaurant_model.dart';

abstract class RestaurantRepository {
  Future<FResult<List<FRestaurant>>> fetchNearestRestaurant([int limit = 5]);
}
