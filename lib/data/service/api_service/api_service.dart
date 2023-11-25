import 'dart:convert';

import 'package:weathe_app/constants/custom_exception.dart';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathe_app/data/service/geo_locator.dart';

import '../../../constants/api_keys.dart';
import '../../../models/weather_model1.dart';

class OpenWeatherApi {
  Position? _position;
  ApiResponseModel? _apiResponseModel;
  // double? lat;
  // double? longt;

  Future<ApiResponseModel> getLocationWeather(
      //getting location weather in two events:
      //user's current location or when user searchs for a location's weather
      //we then get the lat and longt of that
      {double? lat,
      double? longt}) async {
    if (lat == null || longt == null) {
//to get current position
      _position = await GeoLocatorService().getcurrentPosition();

      if (_position == null) {
        throw CustomException(message: "  Failed to get current Position");
      }
    }

    _apiResponseModel = await _getWeather(
        lat: lat ?? _position!.latitude, longt: longt ?? _position!.longitude);
    if (_apiResponseModel == null) {
      throw CustomException(message: " Failed to get weather data");
    }
    return _apiResponseModel!;
  }

  Future<ApiResponseModel?> _getWeather(
      {required double lat, required double longt}) async {
    //to do : handle errors appropriately
    ApiResponseModel? apiResponseModel;
    try {
      // final cityName = 'London';
      // final url1 =
      //     "https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey1}&units=metric";
      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$longt&appid=${apiKey1}&units=metric";

      //make sure the pc and the device(emulator or physical) have the same
      //internet connection source

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        log("response body = ${response.body}");

        apiResponseModel = ApiResponseModel.fromJson(response.body);
        log("..........");
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

  // Future<List<String>> getLocationSuggesstions(String query) async {
  //   List<String> locations = [];
  //   try {
  //     final url =
  //         "https://api.openweathermap.org/data/2.5/find?q=${query}&appid=${apiKey1}";
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       log("Fetch suggestions success");
  //       final fetchedData = jsonDecode(response.body);
  //       final list = fetchedData['list'];
  //       for (var element in list) {
  //         log("element = $element");
  //         log("name = ${element['name']}");
  //         locations.add(element['name']);
  //       }

  //       //  return list.map((e) => e['name'] as String).toList();
  //     } else {
  //       log("Fetch suggestions failed with status code ${response.statusCode} and error = ${response.body}");
  //     }
  //   } catch (e) {
  //     return locations;
  //     //throw CustomException(message: 'Error Fetching suggestions');
  //   }
  //   return locations;
  // }
}
