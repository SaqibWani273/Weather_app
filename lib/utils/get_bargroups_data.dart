import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/hourly_weather_model.dart';

List<BarChartGroupData>? getBarGroupsData(
    List<ForecastWeatherModel> dailyForecastList) {
  return dailyForecastList
      .asMap()
      .entries
      .map((MapEntry<int, ForecastWeatherModel> e) => BarChartGroupData(
            x: e.key,
            barRods: [
              BarChartRodData(
                fromY: e.value.main.tempMin,
                toY: e.value.main.tempMax,
                width: 15.0,
                color: Colors.white,
              ),
              //this is just a hack to get the min temp at bottom
              BarChartRodData(
                fromY: e.value.main.tempMin.toInt().toDouble(),
                toY: e.value.main.tempMin.toInt().toDouble(),
                width: 15.0,
                color: Colors.white,
              ),
            ],
            showingTooltipIndicators: [0, 1],
          ))
      .toList();
}
