import 'package:weathe_app/models/weather_model1.dart';

class TodayScreenUiData {
  String getTemp(ApiResponseModel api) {
    return api.main.temp.round().toString();
  }

  List<MainWeatherInfo> getMainWeatherInfo(ApiResponseModel api) {
    return [
      MainWeatherInfo(
        name: "Humidity",
        info: "${api.main.humidity.toString()}%",
      ),
      MainWeatherInfo(
        name: "Visibility",
        info: "${((api.visibility / 1000).round()).toString()} km",
      ),
      MainWeatherInfo(
        name: "Wind",
        info: "${((api.wind.speed * 3.6).round()).toString()} km/h",
      )
    ];
  }
}

class MainWeatherInfo {
  final String name;
  final String info;
  MainWeatherInfo({
    required this.name,
    required this.info,
  });
}
