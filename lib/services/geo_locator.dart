import 'package:geolocator/geolocator.dart';

import '../constants/custom_exception.dart';

class GeoLocatorService {
  Future<Position?> getcurrentPosition() async {
    LocationPermission permission;
    final bool locationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      // return Future.error('Location Services are Disabled');
      throw CustomException(
        message: "Location Services are Disabled",
        errorType: ErrorType.locationServicesDisabled,
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time we could try
        // return Future.error('Location permission are denied');
        throw CustomException(
          message: "Please Allow location permission",
          errorType: ErrorType.locationpermissionDenied,
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      // return Future.error('Location permission are permanently denied');
      throw CustomException(
        message: "Location permissions were denied !!",
        errorType: ErrorType.locationPermissionDeniedPermanently,
      );
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
