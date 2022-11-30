import 'place_model.dart';

abstract class PlacesSearchRepository {
  Future<List<FPlace>> searchPlaces(
      String query, double latitude, double longtitude);
  Future<String> calculateDistance(
      double srcLat, double srcLng, double desLat, double desLng);
}
