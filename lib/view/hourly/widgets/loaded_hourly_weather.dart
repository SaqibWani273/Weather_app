import 'package:flutter/material.dart';
import 'package:weathe_app/view/hourly/widgets/weather_chart.dart';

import '../../../models/hourly_weather_model.dart';

class LoadedHourlyWeather extends StatefulWidget {
  final List<HourlyWeatherModel> hourlyWeatherList;
  const LoadedHourlyWeather({super.key, required this.hourlyWeatherList});

  @override
  State<LoadedHourlyWeather> createState() => _LoadedHourlyWeatherState();
}

class _LoadedHourlyWeatherState extends State<LoadedHourlyWeather> {
  int currentIndex = 0;
  void _changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.only(top: 150),
        height: MediaQuery.of(context).size.height * 0.5,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/cloud_bg2.jpg"),
              fit: BoxFit.fill),
        ),
      ),
      Container(
        // color: Colors.grey.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.1,
                //  color: Colors.blue.shade900.withOpacity(0.3),
                padding: EdgeInsets.only(top: 15),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            _changeIndex(0);
                          },
                          child: Text("  Temperature  ",
                              style: TextStyle(color: Colors.white)),
                          style: currentIndex == 0
                              ? TextButton.styleFrom(
                                  backgroundColor: Colors.grey.withOpacity(0.9))
                              : null,
                        ),
                        SizedBox(height: 8.0),
                        if (currentIndex ==
                            0) // Adjust spacing between text and underline
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the radius for rounded ends
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              height:
                                  4.0, // Adjust the thickness of the underline
                              color: Colors.blue
                                  .shade300, // Choose the color of the underline
                              width: double.infinity,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            _changeIndex(1);
                          },
                          child: Text("    Clouds    ",
                              style: TextStyle(color: Colors.white)),
                          style: currentIndex == 1
                              ? TextButton.styleFrom(
                                  backgroundColor: Colors.grey.withOpacity(0.9))
                              : null,
                        ),
                        SizedBox(height: 8.0),
                        if (currentIndex == 1)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the radius for rounded ends
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              height:
                                  4.0, // Adjust the thickness of the underline
                              color: Colors.blue
                                  .shade300, // Choose the color of the underline
                              width: double.infinity,
                            ),
                          ),
                      ],
                    ),
                  )
                ])),
            currentIndex == 0
                ? WeatherChart(hourlyWeatherList: widget.hourlyWeatherList)
                : WeatherChart(
                    hourlyWeatherList: widget.hourlyWeatherList,
                    showClouds: true,
                  ),
            //   if (currentIndex == 0)
            // Container(
            //   color: Colors.blue.shade900.withOpacity(0.3),
            //   padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
            //   child: Column(children: [
            //     const SizedBox(
            //       height: 5,
            //     ),
            //     Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           Expanded(
            //             child: Text("__.__  Temp",
            //                 style: TextStyle(
            //                     color: Colors.white70, fontSize: 15)),
            //           ),
            //           Expanded(
            //             child: Text("--.--  Real Feel",
            //                 style: TextStyle(
            //                     color: Colors.white70, fontSize: 15)),
            //           ),
            //           Expanded(
            //             child: Row(
            //               children: [
            //                 Icon(
            //                   Icons.water_drop_sharp,
            //                   color: Colors.white70,
            //                 ),
            //                 Text(" Humidity",
            //                     style: TextStyle(
            //                         color: Colors.white70, fontSize: 15)),
            //               ],
            //             ),
            //           )
            //         ])
            //   ]),
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("3-Hourly Weather Forecast for 5-days ",
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                Icon(Icons.arrow_forward_sharp)
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
