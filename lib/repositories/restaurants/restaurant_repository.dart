import '../result.dart';
import 'restaurant_model.dart';

abstract class RestaurantRepository {
  Future<FResult<List<FRestaurant>>> fetchNearestRestaurants(
      [FRestaurant? restaurant, int limit = 5]);
}
