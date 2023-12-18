import 'package:weathe_app/models/weather_model.dart';
import 'package:weathe_app/utils/date_formatter.dart';

import 'detailed_hourly_const.dart';

Map<String, dynamic> getMoreDetails(ApiResponseModel apiResponseModel,
    {required DateFormatter dateFormatter}) {
  return {
    "Temperature": "${apiResponseModel.main.temp.round()}°c",
    "Real Feel": "${apiResponseModel.main.feelsLike.round().round()}°c",
    "Humidity": "${apiResponseModel.main.humidity.round()}%",
    //speed is in m/s for metric and miles/h for imperial
    "Wind Speed": " ${apiResponseModel.wind.speed.round()} m/s",
    "Winds From": getWindDirection(apiResponseModel.wind.deg.round()),
    "Visibility": "${apiResponseModel.visibility / 1000} km",
    "Pressure ": "${apiResponseModel.main.pressure.round()} hpa",
    "Wind Gust": "${apiResponseModel.wind.gust?.round()} m/s",
    "Cloud Cover": "${apiResponseModel.clouds.all.round()}%",
    "Min Temp": "${apiResponseModel.main.tempMin.round()}°c",
    "Max Temp": "${apiResponseModel.main.tempMax.round()}°c",
    "Sunrise": getSunrise(apiResponseModel.sys.sunrise, dateFormatter),
    "Sunset": getSunrise(apiResponseModel.sys.sunset, dateFormatter),
    "Country": apiResponseModel.sys.country,
    "City": apiResponseModel.name,
    "Weather": apiResponseModel.weather[0].main,
    "name": apiResponseModel.name,
    'icon': apiResponseModel.weather[0].icon,
  };
}

String getSunrise(int sunrise, DateFormatter dateFormatter) {
  final date = dateFormatter.getCurrentDateTimeofLocation(dtInMillis: sunrise);
  return "${date.hour}:${date.minute}";
}
