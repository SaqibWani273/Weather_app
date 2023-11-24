import 'package:weathe_app/constants/custom_exception.dart';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../../models/weather_model1.dart';

const apiKey = "91777aba880f06c50fe03cedd49f5009";
const apiKey1 = "213a692e38f27394801cba5145a86484";

class ApiService {
  Position? _position;
  ApiResponseModel? _apiResponseModel;

  Future<ApiResponseModel> getCurrentLocationWeather() async {
//to get current position
    _position = await _getcurrentPosition();

    if (_position == null) {
      // return Future.error(" Failed to get current position");
      throw CustomException(message: "  Failed to get current Position");
    }
    _apiResponseModel = await _getWeather(_position!);
    if (_apiResponseModel == null) {
      //  return Future.error("Failed to get weather data");
      throw CustomException(message: " Failed to get weather data");
    }
    return _apiResponseModel!;
  }

  Future<Position?> _getcurrentPosition() async {
    LocationPermission permission;
    final bool locationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) {
      // return Future.error('Location Services are Disabled');
      throw CustomException(message: "Location Services are Disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time we could try
        // return Future.error('Location permission are denied');
        throw CustomException(message: "Location permission are denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      // return Future.error('Location permission are permanently denied');
      throw CustomException(
          message: "Location permission are permanently denied");
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<ApiResponseModel?> _getWeather(Position position) async {
    //to do : handle errors appropriately
    ApiResponseModel? apiResponseModel;
    try {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=${apiKey1}&units=metric";

      //make sure the pc and the device(emulator or physical) have the same
      //internet connection source

      final response = await http.get(Uri.parse(url));
      log("...");
      if (response.statusCode == 200) {
        //success
        log("code==200");
        log("response body = ${response.body}");
        log("bosytypoe= ${response.body.runtimeType}");
        apiResponseModel = ApiResponseModel.fromJson(response.body);
      } else {
        log("response = ${response.statusCode}");
      }
    } catch (e) {
      log("error occurred in getWeather: ${e}");
      throw CustomException(
          message:
              "Error Fetching data.\nMake sure you have an active internet connection");
    }
    if (apiResponseModel == null) {
      return null;
    }
    return apiResponseModel;
  }
}
