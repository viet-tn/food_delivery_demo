import 'dart:async';
import 'dart:math' hide log;

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../base/cubit.dart';
import '../../../base/state.dart';
import '../../../config/secrets.dart';
import '../../../repositories/users/coordinate.dart';

part 'order_tracking_state.dart';

class OrderTrackingCubit extends FCubit<OrderTrackingState> {
  OrderTrackingCubit({
    required Coordinate source,
    required Coordinate destination,
  }) : super(
          OrderTrackingState(
            source: source,
            destination: destination,
          ),
        );

  Timer? timer;

  void init() async {
    final result = await GetIt.I<PolylinePoints>().getRouteBetweenCoordinates(
      Credentials.googleMapApiKey,
      PointLatLng(state.source.latitude, state.source.longitude),
      PointLatLng(state.destination.latitude, state.destination.longitude),
      avoidHighways: true,
    );

    if (result.points.isEmpty) return;
    var temp = <LatLng>[];

    for (var point in result.points) {
      temp.add(LatLng(point.latitude, point.longitude));
    }

    while (true) {
      final generated = _polylineGenerator(temp);
      if (generated.length == temp.length) break;

      temp = generated;
    }

    emitValue(state.copyWith(polylinesCoordinates: temp));
  }

  void onMapCreated(GoogleMapController controller,
      {required void Function() onOrderDelivered}) async {
    // Simulate delivery proccess by periodicly remove first point of
    // polylinesCoordinates
    timer?.cancel();
    timer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) async {
        if (state.polylinesCoordinates.isEmpty) {
          onOrderDelivered();
          timer?.cancel();
          return;
        }

        final update = state.polylinesCoordinates.sublist(1);

        emit(
          state.copyWith(
            polylinesCoordinates: update,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

List<LatLng> _polylineGenerator(List<LatLng> src) {
  List<LatLng> result = [];
  var threshHold = 1e-3; //m
  for (var i = 0; i < src.length - 1; i++) {
    result.add(src[i]);
    final relativeDistance = _calulateRelativeDistance(src[i], src[i + 1]);
    if (relativeDistance > threshHold) {
      result.add(_calculateCenter(src[i], src[i + 1]));
    }
  }
  result.add(src.last);
  return result;
}

double _calulateRelativeDistance(
  LatLng p1,
  LatLng p2,
) {
  return sqrt(
      pow(p1.latitude - p2.latitude, 2) + pow(p1.longitude - p2.longitude, 2));
}

LatLng _calculateCenter(LatLng p1, LatLng p2) {
  return LatLng(
      (p1.latitude + p2.latitude) / 2, (p1.longitude + p2.longitude) / 2);
}
