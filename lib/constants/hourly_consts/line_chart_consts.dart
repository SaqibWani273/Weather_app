import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';

List<LineChartBarData> getLineBarsData(
    List<ForecastWeatherModel> hourlyForecastList, bool showClouds) {
  return [
    LineChartBarData(
      barWidth: 5.0,
      spots: hourlyForecastList
          .asMap()
          .entries
          .map<FlSpot>((MapEntry<int, ForecastWeatherModel> entry) {
        return showClouds
            ? FlSpot(entry.key.toDouble(), entry.value.clouds.all.toDouble())
            : FlSpot(entry.key.toDouble(), entry.value.main.temp);
      }).toList(),

      isCurved: false,

      //by default changes the color of both tooltip and the line
      color: Colors.white,
    ),
    if (showClouds != true)
      LineChartBarData(
          dotData: const FlDotData(show: false),
          barWidth: 2.0,
          spots: hourlyForecastList
              .asMap()
              .entries
              .map<FlSpot>((MapEntry<int, ForecastWeatherModel> entry) {
            return FlSpot(entry.key.toDouble(), entry.value.main.feelsLike);
          }).toList(),
          isCurved: false,

          //by default changes the color of both tooltip and the line
          color: Colors.deepPurple,
          dashArray: [5, 5]),
  ];
}
