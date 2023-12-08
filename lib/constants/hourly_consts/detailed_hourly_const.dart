import 'package:weathe_app/models/hourly_weather_model.dart';

Map<String, dynamic> getMainHourDetails(HourlyWeatherModel hourlyWeather) {
  return {
    "Real Feel": "${hourlyWeather.main.feelsLike}°c",
    "Humidity": "${hourlyWeather.main.humidity}%",
    "Percipitation": "${hourlyWeather.probOfPercpipitation.toInt()}%",
    //speed is in m/s for metric and miles/h for imperial
    "Wind Speed": " ${hourlyWeather.wind.speed} m/s",

    "Winds From": getWindDirection(hourlyWeather.wind.deg),
    "Visibility": "${hourlyWeather.visibility / 1000} km",
    "Pressure ": "${hourlyWeather.main.pressure} hpa",
    "Wind Gust": "${hourlyWeather.wind.gust} m/s",
    "Part Of Day": getPartOfDay(hourlyWeather.sys.partOfDay),
    "Cloud Cover": "${hourlyWeather.clouds.all}%",
    "Min Temp": "${hourlyWeather.main.tempMin}°c",
    "Max Temp": "${hourlyWeather.main.tempMax}°c",
    "Hour": hourlyWeather.hour,
  };
}

//N (-45 to 45), E (45 to 135), S (135 to 225) and W (225 to 315).
String getWindDirection(int deg) {
  if (deg >= 315 && deg <= 360 || deg >= 0 && deg <= 45) {
    return "North";
  } else if (deg >= 45 && deg <= 135) {
    return "East";
  } else if (deg >= 135 && deg <= 225) {
    return "South";
  } else {
    return "West";
  }
}

String getPartOfDay(String partOfDay) {
  if (partOfDay == "d") {
    return "Day";
  } else {
    return "Night";
  }
}
