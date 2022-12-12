import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../config/secrets.dart';
import 'place_model.dart';
import 'places_search_repository.dart';

class GooglePlacesSearchRepository implements PlacesSearchRepository {
  const GooglePlacesSearchRepository(this._client);

  final http.Client _client;
  static const _authority = 'maps.googleapis.com';

  @override
  Future<List<FPlace>> searchPlaces(
      String query, double latitude, double longtitude) async {
    const unencodedPath = '/maps/api/place/textsearch/json';
    final result = <FPlace>[];

    final Map<String, dynamic> queryParameters = {
      'location': '$latitude,$longtitude',
      'query': query,
      'key': Credentials.googleMapApiKey,
    };
    final url = Uri.https(
      _authority,
      unencodedPath,
      queryParameters,
    );

    var response = await _client.get(
      url,
    );
    if (response.statusCode != 200) {
      return result;
    }

    List<dynamic> data = jsonDecode(response.body)['results'];

    for (var element in data) {
      result.add(
        FPlace(
          name: element['name'],
          address: element['formatted_address'],
          latitude: element['geometry']['location']['lat'],
          longtitude: element['geometry']['location']['lng'],
        ),
      );
    }

    return result;
  }

  @override
  Future<List<int>> calculateDistance(
      double srcLat, double srcLng, double desLat, double desLng) async {
    const unencodedPath = '/maps/api/distancematrix/json';

    final Map<String, dynamic> queryParameters = {
      'destinations': '$desLat,$desLng',
      'origins': '$srcLat,$srcLng',
      'key': Credentials.googleMapApiKey,
    };
    final url = Uri.https(
      _authority,
      unencodedPath,
      queryParameters,
    );

    var response = await _client.get(
      url,
    );
    if (response.statusCode != 200) {
      throw 'Distance cannot be calculated!';
    }

    List<dynamic> data = jsonDecode(response.body)['rows'];

    return [
      data[0]['elements'][0]['distance']['value'] ?? 0,
      data[0]['elements'][0]['duration']['value'] ?? 0,
    ];
  }
}
