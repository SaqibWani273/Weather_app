// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';
import 'package:weathe_app/utils/date_formatter.dart';

class TileData {
  final List<ForecastWeatherModel> hourlyForecastList;
  // final DateTime sunrise;
  // final DateTime sunset;
  final int timeZone;
  final int sunriseDate;
  final int sunsetDate;
  TileData({
    required this.hourlyForecastList,
    // required this.sunrise,
    // required this.sunset,
    required this.timeZone,
    required this.sunriseDate,
    required this.sunsetDate,
  });
  AxisTitles getTileData({
    bool isTopTiles = false,
    required BuildContext context,
    bool showClouds = false,
  }) {
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
      ),
    );
  }

  Widget _getHour(double val, {bool showClouds = false}) {
    //only return text if val is a whole number
    if (val == val.toInt()) {
      final hourlyWeather = hourlyForecastList[val.toInt()];
      var text = hourlyWeather.hour;

      final currentDate = DateFormatter().getCurrentDateTimeofLocation(
          timeZoneOffsetFromUtc: timeZone, dtInMillis: hourlyWeather.dt);
      final sunrise = DateFormatter().getCurrentDateTimeofLocation(
          timeZoneOffsetFromUtc: timeZone, dtInMillis: sunriseDate);
      final sunset = DateFormatter().getCurrentDateTimeofLocation(
          timeZoneOffsetFromUtc: timeZone, dtInMillis: sunsetDate);
      final String day = DateFormatter().getFormattedDay(currentDate);

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
              child: currentDate.hour < sunrise.hour ||
                      currentDate.hour > sunset.hour
                  ? const Icon(
                      Icons.nights_stay,
                      color: Colors.blue,
                    )
                  : Icon(
                      showClouds ? Icons.cloud : Icons.sunny,
                      color: showClouds ? Colors.white : Colors.amber.shade600,
                    ),
            ),
          ]);
      // return hourlyForecastList[val.toInt()].main.temp.toString();
    } else {
      return const Text('');
    }
  }

  Widget _getHumidity(double val) {
    if (val == val.toInt()) {
      final text = "${hourlyForecastList[val.toInt()].main.humidity}%";
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.water_drop_sharp,
            color: Colors.lightBlue.shade100,
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
