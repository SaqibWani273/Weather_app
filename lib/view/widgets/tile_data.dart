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
              height: 60,
              child: isTopTiles ? _getHour(value) : _getHumidity(value),
            ),
          ),
        );
      },
    ));
  }

  Widget _getHour(double val) {
    if (val == val.toInt()) {
      final text = hourlyWeatherList[val.toInt()].hour;
      return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const Expanded(
              flex: 1,
              child: Icon(
                Icons.cloud,
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
