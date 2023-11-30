import 'package:weathe_app/constants/error_type.dart';

class CustomException implements Exception {
  final String message;
  final ErrorType errorType;
  CustomException({required this.message, required this.errorType});
}
