import 'place_model.dart';

abstract class PlacesSearchRepository {
  Future<List<FPlace>> searchPlaces(
      String query, double latitude, double longtitude);
      /// distance (meter) + duration (second)
  Future<List<int>> calculateDistance(
      double srcLat, double srcLng, double desLat, double desLng);
}
