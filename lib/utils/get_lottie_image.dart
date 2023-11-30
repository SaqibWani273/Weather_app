import 'package:lottie/lottie.dart';
import 'package:weathe_app/constants/custom_exception.dart';

import '../constants/error_type.dart';

LottieBuilder getLottieImage(CustomException customException) {
  switch (customException.errorType) {
    case ErrorType.locationpermissionDenied:
      return Lottie.asset(
        'assets/lottie/no_location.json',
      );
    case ErrorType.locationServicesDisabled:
      return Lottie.asset(
        'assets/lottie/no_location.json',
      );
    case ErrorType.locationPermissionDeniedPermanently:
      return Lottie.asset(
        'assets/lottie/no_location.json',
      );
    case ErrorType.internetConnection:
      return Lottie.asset(
        'assets/lottie/network_error.json',
      );
    case ErrorType.unknown:
      return Lottie.asset(
        //to do: change lottie file later
        'assets/lottie/network_error.json',
      );
    default:
      return Lottie.asset(
        //to do: change lottie file later
        'assets/lottie/network_error.json',
      );
  }
}
