import 'dart:developer';

import 'package:weathe_app/data/service/api_service.dart';
import 'package:weathe_app/data/service/firestore_service.dart';
import 'package:weathe_app/models/complete_data_model.dart';
import 'package:weathe_app/models/weather_model.dart';
import 'package:weathe_app/models/weather_model1.dart';
import 'package:weathe_app/utils/get_firestore_destination.dart';

class WeatherRepository {
  //get everything about current location, i.e. weather, image, lottie file
  Future<WeatherModel> getCompleteData() async {
    ApiResponseModel? _apiResponseModel;
    String? _imageUrl;
    String? _lottieUrl;
    try {
//weather from oepnweathermapapi
      _apiResponseModel = await ApiService().getCurrentLocationWeather();
      log('weather responsed ');
      //bg image and lottie file from firestore
      //get type of background needed
      // final destination=getFirestoreDestination(weather.weatherStatus);
      const destination = "weather_app/background/rain";
      //now get the image and lottie url from firestore
      final imageAndLottie =
          await FirestoreService().getImageAndLottie(destination);
      _imageUrl = imageAndLottie['image'];
      _lottieUrl = imageAndLottie['lottie'];
    } catch (e) {
      log("Error : $e");
    }
    return WeatherModel(
        apiResponseModel: _apiResponseModel!,
        imageUrl: _imageUrl!,
        lottieUrl: _lottieUrl!);
  }
}
