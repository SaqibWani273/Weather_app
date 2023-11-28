// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/view/widgets/tile_data.dart';

import '../view_model/weather_bloc/weather_bloc.dart';
import 'dart:developer';

class HourlyScreen extends StatefulWidget {
  const HourlyScreen({super.key});

  @override
  State<HourlyScreen> createState() => _HourlyScreenState();
}

class _HourlyScreenState extends State<HourlyScreen> {
  late AxisTitles noTiles;
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchHourlyWeatherEvent());
    noTiles = const AxisTitles(sideTitles: SideTitles(showTitles: false));
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
        //  height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.blue.shade900.withOpacity(0.3),
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is LoadingWeatherState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadedHourlyWeatherState) {
            var hr = 0;
            final tileData =
                TileData(hourlyWeatherList: state.hourlyWeatherList);
            //main chart lines list (here only one)
            final lineBarsData = [
              LineChartBarData(
                barWidth: 5.0,
                spots: state.hourlyWeatherList.map((e) {
                  final hrInDouble = hr.toDouble();
                  //   log("x= $hrInDouble  y= ${e.main.temp}");
                  hr++;

                  return FlSpot(hrInDouble, e.main.temp);
                }).toList(),
                isCurved: true,
                //   show: false,
                //   dotData: FlDotData(show: false),
                //change the color of both tooltip and the line
                color: Colors.white,
              ),
            ];
            hr = 0;

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: deviceWidth,
              child: Container(
                height: 200,
                width: deviceWidth,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.only(left: 40),
                    height: 200,
                    //multiplying 0.2 to show 5 values in each screen
                    width: state.hourlyWeatherList.length * deviceWidth * 0.2,
                    child: LineChart(
                      LineChartData(
                        //to disable show data on touch
                        lineTouchData: LineTouchData(
                          enabled: false,
                          //to customize tooltip
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (List<LineBarSpot> lineBarSpots) {
                              return lineBarSpots
                                  .map((LineBarSpot lineBarSpot) =>
                                      LineTooltipItem(
                                          "${lineBarSpot.y.round().toString()}°",
                                          const TextStyle(color: Colors.white)))
                                  .toList();
                            },
                            tooltipBgColor: Colors.transparent,
                            tooltipRoundedRadius: 5,
                            tooltipPadding: EdgeInsets.all(0),
                          ),
                        ),

                        //to show tooltip permanently on the screen
                        showingTooltipIndicators:
                            state.hourlyWeatherList.map((hourlyWeatherModel) {
                          return ShowingTooltipIndicators(
                            [
                              LineBarSpot(
                                lineBarsData[0],
                                lineBarsData.indexOf(lineBarsData[0]),
                                lineBarsData[0].spots[hr++],
                              )
                            ],
                          );
                        }).toList(),

                        minX: 0,
                        minY: 0,
                        maxY: 25,
                        //to hide the grid
                        gridData: const FlGridData(
                          show: false,
                        ),
                        //to hide the borders
                        borderData: FlBorderData(show: false),
                        //to show data around four sides of graph
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: noTiles,
                          rightTitles: noTiles,
                          topTitles: tileData.getTileData(
                              isTopTiles: true, context: context),
                          bottomTitles: tileData.getTileData(context: context),
                        ),
                        //this is the actual chart line
                        lineBarsData: lineBarsData,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          if (state is WeatherErrorState) {
            return Container(
                color: Colors.white.withBlue(123),
                child: Center(child: Text(state.error!)));
          }
          return Container(
              color: Colors.white.withBlue(123),
              child: const Center(
                  child: Text(
                "Something went wrong",
              )));
        }));
  }
}
