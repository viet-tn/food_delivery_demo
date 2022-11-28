part of 'map_screen_cubit.dart';

class MapScreenState extends FState {
  const MapScreenState({
    super.status,
    super.errorMessage,
    this.lat,
    this.lon,
    this.address,
    this.suggestions = const <FPlace>[],
  });

  final double? lat;
  final double? lon;
  final String? address;
  final List<FPlace> suggestions;

  @override
  List<Object?> get props => [
        ...super.props,
        lat,
        lon,
        address,
        suggestions,
      ];

  @override
  MapScreenState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    double? lat,
    double? lon,
    String? address,
    List<FPlace>? suggestions,
  }) {
    return MapScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      address: address ?? this.address,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}
