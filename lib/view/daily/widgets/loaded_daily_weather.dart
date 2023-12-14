import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/repositories/weather_repository.dart';
import '../../../utils/date_formatter.dart';
import '../../../utils/get_bargroups_data.dart';

import '../../../models/hourly_weather_model.dart';

import 'package:fl_chart/fl_chart.dart';

import '../../detailed_weather/detailed_weather_screen.dart';

class LoadedDailyWeather extends StatelessWidget {
  final List<ForecastWeatherModel> dailyWeatherList;
  const LoadedDailyWeather({super.key, required this.dailyWeatherList});

  @override
  Widget build(BuildContext context) {
    final apiResponseModel =
        context.read<WeatherRepository>().currentWeatherModel!.apiResponseModel;
    final formattedDateTime =
        context.read<WeatherRepository>().dateFormatter.formattedDateTime;
    double lowestTemp = 100;
    double highestTemp = -100;
    for (var element in dailyWeatherList) {
      if (element.main.tempMin < lowestTemp) {
        lowestTemp = element.main.tempMin;
      }
      if (element.main.tempMax > highestTemp) {
        highestTemp = element.main.tempMax;
      }
    }
    // lowestTemp = dailyWeatherList.map((e) => e.main.tempMin).toList();
    const noTitles = AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
    return Container(
        alignment: Alignment.center,
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: BarChart(BarChartData(
                maxY: highestTemp + 3,
                minY: lowestTemp - 3,
                barGroups: getBarGroupsData(dailyWeatherList),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: noTitles,
                  rightTitles: noTitles,
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final dailyWeather =
                                dailyWeatherList[value.toInt()];

                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.water_drop_sharp,
                                  color: Colors.lightBlue.shade100,
                                ),
                                Text(
                                  "${dailyWeather.main.humidity.round()}%",
                                  style: const TextStyle(fontSize: 15),
                                )
                              ],
                            );
                          }),
                      axisNameWidget: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text("Daily Forecast   "),
                      ),
                      axisNameSize: 50),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 100,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          final dateFormatter =
                              context.read<WeatherRepository>().dateFormatter;
                          final dailyWeather = dailyWeatherList[value.toInt()];
                          final currentDate =
                              dateFormatter.getCurrentDateTimeofLocation(
                                  dtInMillis: dailyWeather.dt);
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${dateFormatter.getFormattedDay(currentDate)}\n${currentDate.day}",
                                      style: TextStyle(fontSize: 15),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Icon(Icons.cloud),
                                ),
                              ]);
                        }),
                    axisNameSize: 100,
                    axisNameWidget: //location and date
                        FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            apiResponseModel.name,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              " (${formattedDateTime.split("-")[1]})",
                              // textScaler: const TextScaler.linear(1.8),
                            ),
                          ),
                          //  const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),

                //to show tooltip
                barTouchData: BarTouchData(
                  touchCallback:
                      (FlTouchEvent event, BarTouchResponse? touchResponse) {
                    //for enter event
                    if (event.runtimeType == FlTapUpEvent &&
                        touchResponse != null) {
                      //    log("event = ${event.runtimeType}");

                      //detail page
                      if (touchResponse.spot != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailedWeather(
                              hourlyForecastList: dailyWeatherList,
                              currentIndex:
                                  touchResponse.spot!.touchedBarGroupIndex,
                              isHourly: false,
                              screenWidth: MediaQuery.of(context).size.width,
                            ),
                          ),
                        );
                      }
                    }
                  },
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                      tooltipHorizontalOffset: 5,
                      tooltipBgColor: Colors.transparent,
                      tooltipMargin: -8,
                      getTooltipItem:
                          (barChartGroupData, int1, barChartRodData, int2) {
                        return BarTooltipItem(
                            int2 == 0
                                ? "${barChartRodData.toY.round()}°c"
                                : "${barChartRodData.fromY.round()}°c",
                            TextStyle(
                                fontSize: 15,
                                inherit: false,
                                color: int2 == 1
                                    ? Colors.lightBlue
                                    : Colors.white));
                      }),
                ),
              )),
            )));
  }
}
