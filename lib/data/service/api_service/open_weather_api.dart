import 'dart:convert';

import 'package:weathe_app/constants/custom_exception.dart';
import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathe_app/data/service/geo_locator.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';
import 'package:weathe_app/utils/get_formatted_datetime.dart';

import '../../../constants/api_keys.dart';
import '../../../models/weather_model1.dart';

class OpenWeatherApi {
  Position? _position;
  ApiResponseModel? _apiResponseModel;
  late double _lat;
  late double _longt;
//this is the main function
  Future<ApiResponseModel> getLocationWeather(
      {double? lat, double? longt}) async {
    //getting location weather in two events:
    //user's current location (this time we'l need to get lat and longt)
    //or when user searchs for any location's weather

    if (lat == null || longt == null) {
//to get current position(or lat and longt)
      _position = await GeoLocatorService().getcurrentPosition();

      if (_position == null) {
        throw CustomException(message: "  Failed to get current Position");
      }
    }
    //update _lat and _longt
    _lat = lat ?? _position!.latitude;
    _longt = longt ?? _position!.longitude;
    _apiResponseModel = await _getWeather(lat: _lat, longt: _longt);
    if (_apiResponseModel == null) {
      throw CustomException(message: " Failed to get weather data");
    }

    return _apiResponseModel!;
  } //..........end of getLocationWeather

//this is the helper function
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
  } //..........end of _getWeather

  Future<List<HourlyWeatherModel>> getHourlyWeather(
      {required double lat, required double longt}) async {
    List<HourlyWeatherModel> hourlyWeatherList = [];
    final url =
        "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$longt&appid=$apiKey1&units=metric";
    final response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        //  log("hourly response body = ${response.body}");
        log(" hourly response code = ${response.statusCode}");
        final decodeResponse = jsonDecode(response.body);
        log("decoderesponse = $decodeResponse");
        final timeZone = decodeResponse["city"]["timezone"];

        int hr = 0;
        for (var item in decodeResponse["list"]) {
          final hour = getFormattedDateTime(timeZone, hr: hr);
          hourlyWeatherList.add(HourlyWeatherModel.fromMap(item, hour));
          hr += 3;
        }

        //  apiResponseModel = ApiResponseModel.fromJson(response.body);
        log("..........");
      } else {
        log("hourly response code = ${response.statusCode}");
      }
    } on TypeError catch (e) {
      log("type error occurred in getHourlyWeather:\n stacktrace : ${e.stackTrace}\n error : $e");
      throw CustomException(
          message: "An internal error occurred.\n Please try again later");
    } catch (e) {
      log("error occurred in getHourlyWeather: ${e}");
      throw CustomException(
          message:
              "Error Fetching data.\nMake sure you have an active internet connection");
    }
    return hourlyWeatherList;
  }
}