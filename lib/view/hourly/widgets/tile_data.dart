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
      {bool isTopTiles = false,
      required BuildContext context,
      bool showClouds = false}) {
    return AxisTitles(

        //   axisNameSize: 30,
        sideTitles: SideTitles(
      reservedSize: 55,
      showTitles: true,
      getTitlesWidget: (double value, TitleMeta meta) {
        return SideTitleWidget(
          axisSide: isTopTiles ? AxisSide.top : AxisSide.bottom,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.25,
              height: 80,
              child: isTopTiles
                  ? _getHour(value, showClouds: showClouds)
                  : _getHumidity(value),
            ),
          ),
        );
      },
    ));
  }

  Widget _getHour(double val, {bool showClouds = false}) {
    if (val == val.toInt()) {
      var text = hourlyWeatherList[val.toInt()].hour;
      final date = DateTime.parse(hourlyWeatherList[val.toInt()].dt_txt);
      log("date = ${date.weekday}");
      var day = "";
      switch (date.weekday) {
        case 1:
          day += " Mon";
          break;
        case 2:
          day += " Tue";
          break;
        case 3:
          day += " Wed";
          break;
        case 4:
          day += " Thu";
          break;
        case 5:
          day += " Fri";
          break;
        case 6:
          day += " Sat";
          break;
        case 7:
          day += " Sun";
      }
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "$day\n$text",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                showClouds ? Icons.cloud : Icons.sunny,
                color: Colors.white,
              ),
            ),
          ]);
      // return hourlyWeatherList[val.toInt()].main.temp.toString();
    } else {
      return const Text('');
    }
  }

  Widget _getHumidity(double val) {
    if (val == val.toInt()) {
      final text = "${hourlyWeatherList[val.toInt()].main.humidity}%";
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.water_drop_sharp,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
          )
        ],
      );
    }
    return const Text('');
  }
}
