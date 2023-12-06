import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/models/weather_model1.dart';
import 'package:weathe_app/repositories/weather_repository.dart';
import '../../../models/hourly_weather_model.dart';

import '../../../constants/other_const.dart';
import 'tile_data.dart';

class WeatherChart extends StatelessWidget {
  final List<HourlyWeatherModel> hourlyWeatherList;
  final bool showClouds;
  const WeatherChart({
    super.key,
    required this.hourlyWeatherList,
    this.showClouds = false,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    const noTiles = AxisTitles(sideTitles: SideTitles(showTitles: false));
    final deviceWidth = MediaQuery.of(context).size.width;
    final ApiResponseModel apiResponseModel =
        context.read<WeatherRepository>().weatherModel.apiResponseModel;

//utc date
    // final utcDate = DateTime.fromMillisecondsSinceEpoch(
    //     apiResponseModel.dt * 1000,
    //     isUtc: true);
    // final dateTime = utcDate.add(Duration(seconds: apiResponseModel.timezone));
    // log("hour = ${dateTime.hour}");
    final tempTimezone = apiResponseModel.timezone;

    // //sunrise at utc
    final utcSunrise = DateTime.fromMillisecondsSinceEpoch(
      apiResponseModel.sys.sunrise * 1000,
      isUtc: true,
    );
    final sunrise = utcSunrise.add(
      Duration(seconds: apiResponseModel.timezone),
    );
//sunset at utc
    final utcSunset = DateTime.fromMillisecondsSinceEpoch(
        apiResponseModel.sys.sunset * 1000,
        isUtc: true);
    final sunset = utcSunset.add(
      Duration(seconds: apiResponseModel.timezone),
    );

    final tileData = TileData(
        hourlyWeatherList: hourlyWeatherList,
        sunrise: sunrise,
        sunset: sunset,
        timeZone: tempTimezone);
    //main chart lines list (here only two lines)
    final lineBarsData = [
      LineChartBarData(
        barWidth: 5.0,
        spots: hourlyWeatherList
            .asMap()
            .entries
            .map<FlSpot>((MapEntry<int, HourlyWeatherModel> entry) {
          return showClouds
              ? FlSpot(entry.key.toDouble(), entry.value.clouds.all.toDouble())
              : FlSpot(entry.key.toDouble(), entry.value.main.temp);
        }).toList(),

        isCurved: false,
        //   show: false,
        //   dotData: FlDotData(show: false),
        //by default changes the color of both tooltip and the line
        color: Colors.white,
      ),
      if (showClouds != true)
        LineChartBarData(
            dotData: const FlDotData(show: false),
            barWidth: 2.0,
            spots: hourlyWeatherList
                .asMap()
                .entries
                .map<FlSpot>((MapEntry<int, HourlyWeatherModel> entry) {
              return FlSpot(entry.key.toDouble(), entry.value.main.feelsLike);
            }).toList(),
            isCurved: false,

            //by default changes the color of both tooltip and the line
            color: Colors.deepPurple,
            dashArray: [5, 5]),
    ];

    return Container(
      //  color: const Color.fromARGB(255, 2, 51, 94).withOpacity(0.5),
      //  color: Colors.transparent.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),

                  //multiplying 0.2 to show 5 values in each screen
                  width: hourlyWeatherList.length * deviceWidth * 0.2,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        handleBuiltInTouches: false,
                        //to do : change bg color of currently focused spot
                        //to navigate to detail page on touch
                        touchCallback: (FlTouchEvent event,
                            LineTouchResponse? touchResponse) {
                          log("event = ${touchResponse?.lineBarSpots?.first.spotIndex} ");
                        },
                        //to disable show data on touch
                        enabled: false,
                        //to customize tooltip
                        touchTooltipData: LineTouchTooltipData(
                          // fitInsideVertically: true,
                          getTooltipItems: (List<LineBarSpot> lineBarSpots) {
                            return lineBarSpots.map((LineBarSpot lineBarSpot) {
                              return LineTooltipItem(
                                "${lineBarSpot.y.round().toString()} ${showClouds ? "%" : "°"}",
                                const TextStyle(
                                  inherit: false,
                                  fontSize: 20,
                                ),
                              );
                            }).toList();
                          },
                          tooltipBgColor: Colors.transparent,
                          tooltipRoundedRadius: 2,
                          tooltipPadding: const EdgeInsets.all(0),
                        ),
                      ),

                      //to show tooltip permanently on the screen
                      //show as many tooltips as the number of data points
                      showingTooltipIndicators: hourlyWeatherList
                          .asMap()
                          .entries
                          .map((MapEntry<int, HourlyWeatherModel> entry) {
                        return ShowingTooltipIndicators(
                          [
                            LineBarSpot(
                              lineBarsData[0],
                              lineBarsData.indexOf(lineBarsData[0]),
                              lineBarsData[0].spots[entry.key],
                            ),
                            // LineBarSpot(
                            //   lineBarsData[1],
                            //   lineBarsData.indexOf(lineBarsData[1]),
                            //   lineBarsData[1].spots[entry.key],
                            // )
                          ],
                        );
                      }).toList(),

                      minX: 0,
                      minY: 0,
                      maxY: showClouds ? 150 : 55,

                      //to hide/show the grid
                      gridData: const FlGridData(
                        show: false,
                      ),
                      //to hide/show the borders
                      borderData: FlBorderData(
                        show: false,
                      ),
                      //to show data around four sides of graph
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: noTiles,
                        rightTitles: noTiles,
                        topTitles: tileData.getTileData(
                            isTopTiles: true,
                            context: context,
                            showClouds: showClouds),
                        bottomTitles: tileData.getTileData(context: context),
                      ),
                      //this is the actual chart line/lines
                      lineBarsData: lineBarsData,
                    ),
                    duration: Durations.long1,
                    curve: Curves.easeInOut,
                  ),
                )),
          ),
          if (showClouds != true)
            Container(
              //   color: Colors.blue.shade900.withOpacity(0.3),
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text("__.__  Temp",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 15)),
                      ),
                      Expanded(
                          child: RichText(
                              text: TextSpan(children: [
                        TextSpan(
                            text: "---.---",
                            style: TextStyle(
                                color: Colors.deepPurple, fontSize: 15)),
                        TextSpan(
                          text: " Real Feel",
                        )
                      ]))),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.water_drop_sharp,
                              color: Colors.lightBlue.shade100,
                            ),
                            Text(" Humidity",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 15)),
                          ],
                        ),
                      )
                    ])
              ]),
            ),
        ],
      ),
    );
  }
}
