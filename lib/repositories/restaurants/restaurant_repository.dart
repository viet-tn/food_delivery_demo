import '../result.dart';
import 'restaurant_model.dart';

abstract class RestaurantRepository {
  Future<FResult<List<FRestaurant>>> fetchNearestRestaurants(
      double latitudeSrc, double longitudeSrc,
      [FRestaurant? restaurant, int limit = 5]);
}
