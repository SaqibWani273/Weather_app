import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/hourly_consts/line_chart_consts.dart';
import '../../../models/weather_model1.dart';
import '../../../repositories/weather_repository.dart';
import '../../../models/hourly_weather_model.dart';

import '../../detailed_weather/detailed_weather_screen.dart';
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
    const noTiles = AxisTitles(sideTitles: SideTitles(showTitles: false));
    final deviceWidth = MediaQuery.of(context).size.width;
    final ApiResponseModel apiResponseModel =
        context.read<WeatherRepository>().weatherModel.apiResponseModel;

    final tileData = TileData(
      hourlyWeatherList: hourlyWeatherList,
      timeZone: apiResponseModel.timezone,
      sunriseDate: apiResponseModel.sys.sunrise,
      sunsetDate: apiResponseModel.sys.sunset,
    );
    //main chart lines list (here only two lines)
    final List<LineChartBarData> lineBarsData =
        getLineBarsData(hourlyWeatherList, showClouds);

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
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
                        //for enter event
                        if (event.runtimeType == FlTapUpEvent &&
                            touchResponse != null) {
                          //    log("event = ${event.runtimeType}");

                          //detail page
                          if (touchResponse.lineBarSpots?.first.spotIndex !=
                              null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedWeather(
                                  hourlyWeatherList: hourlyWeatherList,
                                  currentIndex: touchResponse
                                      .lineBarSpots!.first.spotIndex,
                                  isHourly: true,
                                  screenWidth:
                                      MediaQuery.of(context).size.width,
                                ),
                              ),
                            );
                          }
                        }
                        //for hover event
                        //to do: change bg color of currently focused spot
                        if (event.runtimeType == FlPointerHoverEvent) {
                          log("event = ${event.runtimeType}");
                          //get index of that spot
                          final index =
                              touchResponse?.lineBarSpots?.first.spotIndex;
                          log("index = $index");
                        }
                      },
                      //to disable show data on touch
                      enabled: false,
                      //to customize tooltip
                      touchTooltipData: LineTouchTooltipData(
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
                        ],
                      );
                    }).toList(),

                    minX: 0,
                    minY: 0,
                    maxY: showClouds ? 150 : 45,

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
                        showClouds: showClouds,
                      ),
                      bottomTitles: tileData.getTileData(
                        context: context,
                      ),
                    ),
                    //this is the actual chart line/lines
                    lineBarsData: lineBarsData,
                  ),
                  duration: Durations.long1,
                  curve: Curves.easeInOut,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
