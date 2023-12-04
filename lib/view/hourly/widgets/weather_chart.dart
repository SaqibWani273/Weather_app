import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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

    final tileData = TileData(hourlyWeatherList: hourlyWeatherList);
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
            color: Colors.white70,
            dashArray: [5, 5]),
    ];

    return Container(
      //  color: const Color.fromARGB(255, 2, 51, 94).withOpacity(0.5),
      color: Colors.transparent.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),

                    //multiplying 0.2 to show 5 values in each screen
                    width: hourlyWeatherList.length * deviceWidth * 0.2,
                    child: LineChart(
                      LineChartData(
                        //to disable show data on touch
                        lineTouchData: LineTouchData(
                          enabled: false,
                          //to customize tooltip
                          touchTooltipData: LineTouchTooltipData(
                            // fitInsideVertically: true,
                            getTooltipItems: (List<LineBarSpot> lineBarSpots) {
                              return lineBarSpots
                                  .map((LineBarSpot lineBarSpot) {
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
                        maxY: showClouds ? 150 : 25,

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
                  ),
                )),
          ),

          //  if (currentIndex == 0)
          Container(
            //   color: Colors.blue.shade900.withOpacity(0.3),
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: const Column(children: [
              SizedBox(
                height: 5,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                  child: Text("__.__  Temp",
                      style: TextStyle(color: Colors.white70, fontSize: 15)),
                ),
                Expanded(
                  child: Text("--.--  Real Feel",
                      style: TextStyle(color: Colors.white70, fontSize: 15)),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.water_drop_sharp,
                        color: Colors.white70,
                      ),
                      Text(" Humidity",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 15)),
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
