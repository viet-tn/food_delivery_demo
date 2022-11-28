import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../config/secrets.dart';
import '../../result.dart';
import '../../users/coordinate.dart';
import 'geocoding_repository.dart';

class GoogleGeocodingRepository implements GeocodingRepository {
  const GoogleGeocodingRepository(this._client);

  final http.Client _client;
  static const _authority = 'maps.googleapis.com';
  static const _unencodedPath = '/maps/api/geocode/json';

  @override
  Future<FResult<String>> getAddress(double latitude, double longtitude) async {
    try {
      final url = Uri.https(
        _authority,
        _unencodedPath,
        {
          'latlng': '$latitude,$longtitude',
          'key': Credentials.googleMapApiKey,
        },
      );

      var response = await _client.get(
        url,
      );
      if (response.statusCode != 200) {
        return FResult.error('Address not found!');
      }

      List<dynamic> data = jsonDecode(response.body)['results'];

      int index = 0;
      for (var i = 0; i < data.length; i++) {
        if (data[i]['address_components'][0]['types'][0] != 'plus_code') {
          index = i;
          break;
        }
      }

      return FResult.success(data[index]['formatted_address']);
    } catch (e) {
      return FResult.error('Address not found!');
    }
  }

  @override
  Future<FResult<Coordinate>> getCoordinate(String address) {
    // TODO: implement getCoordinate
    throw UnimplementedError();
  }
}
