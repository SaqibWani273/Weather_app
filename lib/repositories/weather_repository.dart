import 'dart:developer';

import 'package:weathe_app/constants/custom_exception.dart';
import 'package:weathe_app/data/service/api_service/api_service.dart';
import 'package:weathe_app/data/service/firestore_service.dart';
import 'package:weathe_app/data/service/api_service/geo_db_service.dart';
import 'package:weathe_app/models/city_model.dart';
import 'package:weathe_app/models/weather_model1.dart';

class WeatherRepository {
  //get everything about current location, i.e. weather, image, lottie file
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
    } on CustomException catch (e) {
      log("Catched Error in WeatherRepository: $e");
      throw CustomException(message: e.message);
    } catch (e) {
      log("Unexpected Error in WeatherRepository: $e");
    }
    return WeatherModel(
        apiResponseModel: apiResponseModel!,
        imageUrl: imageUrl!,
        lottieUrl: lottieUrl);
  }

  Future<List<CityModel>?> getSuggestedCities(String query) async {
    return await GeoDBApi().fetchSuggestedCities(query);
  }

  // Future<List<String>> getLocationSuggesstions(String query) async {
  //   return await OpenWeatherApi().getLocationSuggesstions(query);
  // }
}
