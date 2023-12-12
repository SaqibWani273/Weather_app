import 'package:flutter/material.dart';

import '../../../models/hourly_weather_model.dart';

class LoadedDailyWeather extends StatelessWidget {
  final List<ForecastWeatherModel> dailyWeatherList;
  const LoadedDailyWeather({super.key, required this.dailyWeatherList});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "day: ${dailyWeatherList.map((e) => "${e.day}").toList()}\n minTemp: ${dailyWeatherList.map((e) => "${e.main.tempMin}").toList()}\n maxTemp: ${dailyWeatherList.map((e) => "${e.main.tempMax}").toList()}\n temp : ${dailyWeatherList.map((e) => "${e.main.temp}").toList()}"),
    );
  }
}
