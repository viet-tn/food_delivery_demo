import '../../../../../base/cubit.dart';
import '../../../../../base/state.dart';
import '../../../../../repositories/maps/geocoding/geocoding_repository.dart';
import '../../../../../repositories/maps/search/place_model.dart';
import '../../../../../repositories/maps/search/places_search_repository.dart';

part 'map_screen_state.dart';

class MapScreenCubit extends FCubit<MapScreenState> {
  MapScreenCubit({
    required GeocodingRepository geocodingRepository,
    required PlacesSearchRepository placesSearchRepository,
  })  : _placesSearchRepository = placesSearchRepository,
        _geocodingRepository = geocodingRepository,
        super(const MapScreenState());

  final GeocodingRepository _geocodingRepository;
  final PlacesSearchRepository _placesSearchRepository;

  void onCoordinateChanged(double lat, double lon) async {
    emitLoading();
    final result = await _geocodingRepository.getAddress(lat, lon);

    if (result.isError) {
      emitError(result.error!);
      return;
    }

    emitValue(
      state.copyWith(
        lat: lat,
        lon: lon,
        address: result.data!,
      ),
    );
  }

  void onSearchChanged(String query, double myLat, double myLng) async {
    if (query == '') {
      emitValue(state.copyWith(suggestions: const <FPlace>[]));
      return;
    }

    try {
      final result = await _placesSearchRepository.searchPlaces(
        query,
        state.lat!,
        state.lon!,
      );
      emitValue(state.copyWith(suggestions: result));
    } catch (e) {
      emitError(e.runtimeType.toString());
    }
  }

  /// Clear suggestions when tap on an address
  void onTitleTapped(double latitude, double longtitude) {
    emit(
      state.copyWith(
        lat: latitude,
        lon: longtitude,
        suggestions: const <FPlace>[],
      ),
    );
  }
}
