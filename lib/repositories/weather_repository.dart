import 'dart:developer';

import 'package:weathe_app/constants/custom_exception.dart';
import 'package:weathe_app/data/service/api_service/api_service.dart';
import 'package:weathe_app/data/service/firestore_service.dart';
import 'package:weathe_app/data/service/api_service/geo_db_service.dart';
import 'package:weathe_app/models/city_model.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';
import 'package:weathe_app/models/weather_model1.dart';

class WeatherRepository {
  //get everything about current location, i.e. weather, image, lottie file
  late WeatherModel _weatherModel;

  Future<WeatherModel> getWeatherData({
    double? lat,
    double? longt,
  }) async {
    ApiResponseModel? apiResponseModel;
    String? imageUrl;
    String? lottieUrl;

    try {
//weather from oepnweathermapapi
      apiResponseModel =
          await OpenWeatherApi().getLocationWeather(lat: lat, longt: longt);
      log('weather responsed ');
      //bg image and lottie file from firestore
      //get type of background needed
      // final destination=getFirestoreDestination(weather.weatherStatus);
      const destination = "weather_app/background/clear";
      //now get the image and lottie url from firestore
      final imageAndLottie =
          await FirestoreService().getImageAndLottie(destination);
      imageUrl = imageAndLottie['image'];
      lottieUrl = imageAndLottie['lottie'];
    } catch (e) {
      log("Catched Error in WeatherRepository: $e");
      rethrow;
    }
    _weatherModel = WeatherModel(
        apiResponseModel: apiResponseModel,
        imageUrl: imageUrl!,
        lottieUrl: lottieUrl);
    return _weatherModel;
  }

  Future<List<CityModel>?> getSuggestedCities(String query) async {
    return await GeoDBApi().fetchSuggestedCities(query);
  }

  Future<List<HourlyWeatherModel>> getHourlyWeather() async {
    try {
      return await OpenWeatherApi().getHourlyWeather(
        lat: _weatherModel.apiResponseModel.coord.lat,
        longt: _weatherModel.apiResponseModel.coord.lon,
      );
    } catch (e) {
      log("error in repository =$e");
      rethrow;
    }
  }
}
