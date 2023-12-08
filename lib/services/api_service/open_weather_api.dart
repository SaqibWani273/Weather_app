import 'dart:convert';

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weathe_app/services/geo_locator.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';
import 'package:weathe_app/utils/date_formatter.dart';

import '../../constants/api_keys.dart';
import '../../constants/custom_exception.dart';
import '../../models/weather_model1.dart';

class OpenWeatherApi {
  Position? _position;
  ApiResponseModel? _apiResponseModel;
  late double _lat;
  late double _longt;
//this is the main function
  Future<ApiResponseModel> getLocationWeather(
      {double? lat, double? longt}) async {
    try {
      //getting location weather in two events:
      //user's current location (this time we'l need to get lat and longt)
      //or when user searchs for any location's weather

      if (lat == null || longt == null) {
//to get current position(or lat and longt)
        _position = await GeoLocatorService().getcurrentPosition();

        if (_position == null) {
          throw unknownException;
        }
      }
      //update _lat and _longt
      _lat = lat ?? _position!.latitude;
      _longt = longt ?? _position!.longitude;
      _apiResponseModel = await _getWeather(lat: _lat, longt: _longt);
      if (_apiResponseModel == null) {
        // not sure whether it is right to throw an exception here or not
        throw unknownException;
      }
    } catch (e) {
      rethrow;
    }

    return _apiResponseModel!;
  } //..........end of getLocationWeather

//this is the helper function
  Future<ApiResponseModel?> _getWeather(
      {required double lat, required double longt}) async {
    //to do : handle errors appropriately
    ApiResponseModel? apiResponseModel;
    try {
      final url =
          "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$longt&appid=${apiKey1}&units=metric";

      //make sure the pc and the device(emulator or physical) have the same
      //internet connection source

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        log("response body = ${response.body}");

        apiResponseModel = ApiResponseModel.fromJson(response.body);
      } else if (response.statusCode == 408) {
        //request timeout
        throw internetException;
      } else {
        log("response = ${response.statusCode}");
        throw unknownException;
      }
    } on TypeError catch (e) {
      log("TypeError getWeather:\n : ${e.stackTrace}\n error : $e");
      throw unknownException;
    } on FormatException catch (e) {
      log("FormatException getWeather:\n msg : ${e.message}\n error : ${e}");
      throw unknownException;
    } catch (e) {
      log("error occurred in getWeather: ${e}");
      throw unknownException;
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
        final decodeResponse = jsonDecode(response.body);
        log("decodeResponse = $decodeResponse");

        final timeZone = decodeResponse["city"]["timezone"];

        for (var item in decodeResponse["list"]) {
          //to get formatted hour like 12 AM, 5pm
          final String hour =
              DateFormatter().getFormattedHour(timeZone, item["dt"]);
          hourlyWeatherList.add(HourlyWeatherModel.fromMap(item, hour));
        }
      } else {
        log("hourly response code = ${response.statusCode}");
        throw unknownException;
      }
    } on TypeError catch (e) {
      log("type error in getHourlyWeather:\n stacktrace : ${e.stackTrace}\n error : $e");
      throw unknownException;
    } catch (e) {
      log("error  in getHourlyWeather: ${e}");
      throw internetException;
    }
    return hourlyWeatherList;
  }
}
