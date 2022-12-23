part of 'order_tracking_cubit.dart';

class OrderTrackingState extends FState {
  const OrderTrackingState({
    super.status,
    super.errorMessage,
    required this.destination,
    required this.source,
    this.polylinesCoordinates = const <LatLng>[],
  });

  final Coordinate destination;
  final Coordinate source;
  final List<LatLng> polylinesCoordinates;

  @override
  List<Object?> get props => [
        ...super.props,
        destination,
        source,
        polylinesCoordinates,
      ];

  @override
  OrderTrackingState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    Coordinate? destination,
    Coordinate? source,
    List<LatLng>? polylinesCoordinates,
  }) {
    return OrderTrackingState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      destination: destination ?? this.destination,
      source: source ?? this.source,
      polylinesCoordinates: polylinesCoordinates ?? this.polylinesCoordinates,
    );
  }
}
