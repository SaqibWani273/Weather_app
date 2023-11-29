import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';

import 'tile_data.dart';

class Temp extends StatelessWidget {
  final List<HourlyWeatherModel> hourlyWeatherList;
  const Temp({super.key, required this.hourlyWeatherList});

  @override
  Widget build(BuildContext context) {
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
          return FlSpot(entry.key.toDouble(), entry.value.main.temp);
        }).toList(),

        isCurved: true,
        //   show: false,
        //   dotData: FlDotData(show: false),
        //by default changes the color of both tooltip and the line
        color: Colors.white,
      ),
      // LineChartBarData(
      //     barWidth: 5.0,
      //     spots: hourlyWeatherList
      //         .asMap()
      //         .entries
      //         .map<FlSpot>((MapEntry<int, HourlyWeatherModel> entry) {
      //       return FlSpot(entry.key.toDouble(), entry.value.clouds.all.toDouble());
      //     }).toList(),
      //     isCurved: true,

      //     //by default changes the color of both tooltip and the line
      //     color: Colors.green,
      //     dashArray: [5, 3]),
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: deviceWidth,
      child: Container(
        color: Colors.blue.shade900.withOpacity(0.3),
        height: 200,
        width: deviceWidth,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            height: 200,
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
                      return lineBarSpots.map((LineBarSpot lineBarSpot) {
                        return LineTooltipItem(
                          "${lineBarSpot.y.round().toString()}%",
                          const TextStyle(
                            inherit: false,
                            fontSize: 20,
                          ),
                        );
                      }).toList();
                    },
                    tooltipBgColor: Colors.transparent,
                    tooltipRoundedRadius: 5,
                    tooltipPadding: EdgeInsets.all(0),
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
                  topTitles:
                      tileData.getTileData(isTopTiles: true, context: context),
                  bottomTitles: tileData.getTileData(context: context),
                ),
                //this is the actual chart line/lines
                lineBarsData: lineBarsData,
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
