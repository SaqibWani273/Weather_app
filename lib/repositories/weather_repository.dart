import 'dart:developer';

import 'package:weathe_app/utils/date_formatter.dart';
import 'package:weathe_app/utils/get_daily_forecast.dart';

import '/services/api_service/open_weather_api.dart';
import '/services/firestore_service.dart';
import '/services/api_service/geo_db_service.dart';
import '/models/city_model.dart';
import '/models/hourly_weather_model.dart';
import '/models/weather_model1.dart';

class WeatherRepository {
  var _showedSnackBar = false;

//getter and setter for showedsnackbar
  bool get showedSnackBar => _showedSnackBar;
  set showedSnackBar(bool value) {
    _showedSnackBar = value;
  }

  //get everything about current location, i.e. weather, image, lottie file
  WeatherModel? previousWeatherModel;
  WeatherModel? currentWeatherModel;
  //by default it is hourlyforecast
  List<ForecastWeatherModel>? forecastWeatherModelList;
  DateFormatter dateFormatter = DateFormatter();
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
    //using previousWeatherModel to check whether i need to fetch forecast or not
    //after forecast is fetched, i update the previousWeatherModel to current currentWeatherModel
    previousWeatherModel = currentWeatherModel;
    currentWeatherModel = WeatherModel(
        apiResponseModel: apiResponseModel,
        imageUrl: imageUrl!,
        lottieUrl: lottieUrl);

    return currentWeatherModel!;
  }

  Future<List<CityModel>?> getSuggestedCities(String query) async {
    return await GeoDBApi().fetchSuggestedCities(query);
  }

  Future<List<ForecastWeatherModel>> getForecastWeather(
      {required bool isHourly}) async {
    try {
      //idea is that we should only fetch from api in two cases:
      // 1. first time any of the two screens are triggered
      //2. user changes the location by searching for a new location
      if (forecastWeatherModelList != null &&
          previousWeatherModel == currentWeatherModel) {
        //=> this method was invoked before either by hourly screen or daily
        //& now the different screen is invoking it again
        if (!isHourly) {
          //we need to do furhter processing
          return getDailyForecast(forecastWeatherModelList!, dateFormatter);
        }
        return forecastWeatherModelList!;
      } else {
        //=> forecastWeatherModelList is null
        //this is the first time the method is invoked
        forecastWeatherModelList = await OpenWeatherApi().getHourlyWeather(
          lat: currentWeatherModel!.apiResponseModel.coord.lat,
          longt: currentWeatherModel!.apiResponseModel.coord.lon,
        );
        //to avoid unnecessary api calls
        previousWeatherModel = currentWeatherModel;
        if (!isHourly) {
          //we need to do furhter processing
          return getDailyForecast(forecastWeatherModelList!, dateFormatter);
        }
        return forecastWeatherModelList!;
      }
    } catch (e) {
      log("error in repository =$e");
      rethrow;
    }
  }
}
