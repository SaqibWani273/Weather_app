class CustomException implements Exception {
  final String message;
  final ErrorType errorType;
  CustomException({required this.message, required this.errorType});
}

enum ErrorType {
  locationpermissionDenied,
  locationServicesDisabled,
  locationPermissionDeniedPermanently,
  internetConnection,
  unknown,
}

final CustomException unknownException = CustomException(
  message: "An internal error occurred.",
  errorType: ErrorType.unknown,
);

final CustomException internetException = CustomException(
  message: "Make sure to have an active internet connection",
  errorType: ErrorType.internetConnection,
);
