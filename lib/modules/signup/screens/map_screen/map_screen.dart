import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../constants/ui/ui_parameters.dart';
import '../../../../gen/assets.gen.dart';
import '../../cubit/sign_up_cubit.dart';
import 'cubit/map_screen_cubit.dart';
import 'widgets/address_search_bar.dart';
import 'widgets/set_location_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final _cubit = GetIt.I<MapScreenCubit>();
  final _searchTextEditingController = TextEditingController();
  late final LatLng _center;
  late GoogleMapController _mapController;
  Timer? timer;
  String oldQuery = '';

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.lat, widget.lon);
    _cubit.onCoordinateChanged(widget.lat, widget.lon);
    _searchTextEditingController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    timer?.cancel();
    _mapController.dispose();
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _cubit,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              GoogleMap(
                onMapCreated: _onMapCreated,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 16.0,
                ),
                onTap: (argument) => {
                  log('tap: ${argument.toJson()}'),
                },
                onCameraMove: _onCameraMove,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BlocBuilder<MapScreenCubit, MapScreenState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status ||
                      previous.lat != current.lat ||
                      previous.lon != current.lon,
                  builder: (context, state) {
                    return SetLocationButton(
                      isLoading: state.status.isLoading,
                      onPressed: () {
                        context
                            .read<SignUpCubit>()
                            .onSetLocationButtonPressed(state.lat!, state.lon!);
                        context.read<SignUpCubit>().setLocation(state.address);
                        Navigator.pop(context);
                      },
                      location: state.address,
                    );
                  },
                ),
              ),
              Positioned(
                child: Padding(
                  padding: Ui.screenPadding,
                  child: BlocBuilder<MapScreenCubit, MapScreenState>(
                    buildWhen: (previous, current) =>
                        previous.suggestions != current.suggestions,
                    builder: (context, state) {
                      return AddressSearchBar(
                        controller: _searchTextEditingController,
                        suggestions: state.suggestions,
                        onTitleTapped: (place) {
                          _cubit.onTitleTapped(
                              place.latitude, place.longtitude);
                          _moveToLocation(place.latitude, place.longtitude);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    final style = await DefaultAssetBundle.of(context)
        .loadString(Assets.mapstyles.mapstyleDefault);
    _mapController.setMapStyle(style);
  }

  void _moveToLocation(double latitude, double longtitude) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longtitude),
          zoom: 18.0,
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    // Dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      _cubit.onCoordinateChanged(
          position.target.latitude, position.target.longitude);
    });
  }

  void _onSearchChanged() {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      final newQuery = _searchTextEditingController.text.trim();
      if (newQuery == oldQuery) return;
      _cubit.onSearchChanged(newQuery, widget.lat, widget.lon);
    });
  }
}