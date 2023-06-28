import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants/ui/colors.dart';
import '../../gen/assets.gen.dart';
import '../../repositories/users/coordinate.dart';
import 'cubit/order_tracking_cubit.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({
    super.key,
    required this.source,
    required this.destination,
  });

  final Coordinate source;
  final Coordinate destination;

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  BitmapDescriptor icon = BitmapDescriptor.defaultMarker;
  late final destinationPosition = LatLng(
    widget.destination.latitude,
    widget.destination.longitude,
  );

  late final sourcePosition = LatLng(
    widget.source.latitude,
    widget.source.longitude,
  );

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      Assets.icons.shipper.path,
      mipmaps: false,
    ).then((icon) => this.icon = icon);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<OrderTrackingCubit>(
        param1: widget.source,
        param2: widget.destination,
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
            buildWhen: (previous, current) =>
                previous.polylinesCoordinates.length !=
                current.polylinesCoordinates.length,
            builder: (context, state) {
              if (state.status.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return GoogleMap(
                polylines: {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    points: state.polylinesCoordinates,
                    color: FColors.green,
                    width: 8,
                  )
                },
                onMapCreated: (controller) =>
                    _onMapCreated(context, controller),
                buildingsEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  zoom: 13.0,
                  target: sourcePosition,
                ),
                onTap: (argument) => {},
                minMaxZoomPreference: const MinMaxZoomPreference(11, 19),
                markers: {
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: destinationPosition,
                  ),
                  Marker(
                    icon: icon,
                    markerId: const MarkerId('destination'),
                    position: state.polylinesCoordinates.isEmpty
                        ? destinationPosition
                        : state.polylinesCoordinates.first,
                  ),
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    final style = await DefaultAssetBundle.of(context)
        .loadString(Assets.mapStyles.orderTrackingMapStyle);
    controller.setMapStyle(style).then(
          (_) => context.read<OrderTrackingCubit>().onMapCreated(
                controller,
                onOrderDelivered: () {},
              ),
        );
  }
}
