import 'package:weathe_app/models/hourly_weather_model.dart';

Map<String, dynamic> getMainHourDetails(HourlyWeatherModel hourlyWeather) {
  return {
    "Real Feel": hourlyWeather.main.feelsLike,
    "Humidity": hourlyWeather.main.humidity,
    "Percipitation": hourlyWeather.probOfPercpipitation,
    "Wind Speed": hourlyWeather.wind.speed,
    "Winds From": hourlyWeather.wind.deg,
    "Visibility": hourlyWeather.visibility,
    "Pressure ": hourlyWeather.main.pressure,
    "Wind Gust": hourlyWeather.wind.gust,
    "Day Time": hourlyWeather.sys.partOfDay,
    "Cloud Cover": hourlyWeather.clouds.all,
    "Min Temp": hourlyWeather.main.tempMin,
    "Max Temp": hourlyWeather.main.tempMax,
  };
}
