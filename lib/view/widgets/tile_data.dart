// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';

class TileData {
  final List<HourlyWeatherModel> hourlyWeatherList;
  TileData({
    required this.hourlyWeatherList,
  });
  AxisTitles getTileData(
      {bool isTopTiles = false, required BuildContext context}) {
    return AxisTitles(
        //   drawBelowEverything: false,
        //   axisNameSize: 30,
        sideTitles: SideTitles(
      reservedSize: 35,
      showTitles: true,
      getTitlesWidget: (double value, TitleMeta meta) {
        //     log("meta = ${meta.formattedValue}");
        return SideTitleWidget(
          // space: 0.1,
          axisSide: AxisSide.bottom,
          child: Container(
            // height: 100,
            // width: 100,
            padding: EdgeInsets.only(left: 5),
            child: FittedBox(
              fit: BoxFit.fill,
              child: Container(
                padding: EdgeInsets.only(),
                width: MediaQuery.of(context).size.width * 0.2, //100,
                height: 30, // MediaQuery.of(context).size.width * 0.2, // 100,
                child: Text(
                  isTopTiles ? _getHour(value) : _getHumidity(value),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        );
      },
    ));
  }

  String _getTemp(double val) {
    if (val == val.toInt()) {
      return hourlyWeatherList[val.toInt()].main.temp.round().toString();
    }
    return '';
  }

  String _getHour(double val) {
    if (val == val.toInt()) {
      return hourlyWeatherList[val.toInt()].hour;
      // return hourlyWeatherList[val.toInt()].main.temp.toString();
    }
    return '';
  }

  String _getHumidity(double val) {
    if (val == val.toInt()) {
      return hourlyWeatherList[val.toInt()].main.humidity.toString();
    }
    return '';
  }
}
