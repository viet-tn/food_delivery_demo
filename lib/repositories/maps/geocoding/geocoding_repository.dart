import '../../result.dart';
import '../../users/coordinate.dart';

abstract class GeocodingRepository {
  Future<FResult<String>> getAddress(double latitude, double longtitude);

  Future<FResult<Coordinate>> getCoordinate(String address);
}
