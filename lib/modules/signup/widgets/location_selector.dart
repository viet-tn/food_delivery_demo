import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sign_up_cubit.dart';
import '../../../config/routes/coordinator.dart';
import 'package:geolocator/geolocator.dart';

import '../../../constants/ui/colors.dart';
import '../../../constants/ui/sizes.dart';
import '../../../constants/ui/text_style.dart';
import '../../../constants/ui/ui_parameters.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/ui/drop_shadow.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return DropShadow(
      shadowColor: Colors.grey[50]!,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Image.asset(Assets.icons.pin.path),
                gapW16,
                Expanded(
                  child: BlocSelector<SignUpCubit, SignUpState, String?>(
                    selector: (state) => state.address,
                    builder: (context, state) {
                      return Text(
                        state ?? 'Please choose your address.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: FTextStyles.buttonBlack,
                      );
                    },
                  ),
                ),
              ],
            ),
            gapH32,
            SizedBox(
              height: 60.0,
              child: Ink(
                decoration: const BoxDecoration(
                  color: FColors.setLocationButtonBgColor,
                  borderRadius: Ui.borderRadius,
                ),
                child: InkWell(
                  onTap: () async {
                    final position = await _determinePosition();
                    FCoordinator.pushNamed(Routes.map.name, params: {
                      'lat': position.latitude.toStringAsFixed(15),
                      'lon': position.longitude.toStringAsFixed(15),
                    });
                  },
                  borderRadius: Ui.borderRadius,
                  child: const Center(
                    child: Text(
                      'Set Location',
                      style: FTextStyles.buttonBlack,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    await Geolocator.requestPermission();
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    Geolocator.openAppSettings();
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
