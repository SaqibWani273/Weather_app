import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/constants/other_const.dart';
import 'package:weathe_app/models/weather_model1.dart';
import 'package:weathe_app/repositories/weather_repository.dart';
import 'package:weathe_app/view/hourly/widgets/weather_chart.dart';

import '../../../models/hourly_weather_model.dart';
import '../../../utils/get_formatted_datetime.dart';

final dummmyUrl =
    "https://img.freepik.com/free-vector/sun-light-cloud-transparent_107791-892.jpg?size=626&ext=jpg&uid=R125884824&ga=GA1.1.1043004737.1700320989&semt=ais";

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
    final img = currentIndex == 0
        ? "hourly_screen_pic.png"
        : "hourly_screen_cloud1.png";
    final deviceHeight = MediaQuery.of(context).size.height;
    final apiResponseModel =
        context.read<WeatherRepository>().weatherModel.apiResponseModel;
    final formattedDateTime = getFormattedDateTime(apiResponseModel.timezone);

    return Container(
      color: const Color.fromARGB(255, 2, 51, 94),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15),
      height: deviceHeight,
      //used stack for bottom navigation bar
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //location and date
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: deviceHeight * 0.25,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                formattedDateTime,
                                textScaler: const TextScaler.linear(1.8),
                              ),
                            ),
                          ]),
                    ),
                    const Spacer(),
                  ],
                ),
                Expanded(
                  child: Image.asset(
                    "assets/images/$img",
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15.0),
              //rounded corners
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.transparent.withOpacity(0.3),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //temperature and clouds navigation buttons
                  Expanded(
                    flex: 1,
                    child: Container(
                      // color:
                      //     const Color.fromARGB(255, 2, 51, 94).withOpacity(0.5),
                      height: deviceHeight <= Devices.smallMaxHeight
                          ? 0.15 * deviceHeight
                          : 0.1 * deviceHeight,
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _changeIndex(0);
                                  },
                                  style: currentIndex == 0
                                      ? TextButton.styleFrom(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.9))
                                      : null,
                                  child: const Text("  Temperature  ",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(height: 8.0),
                                if (currentIndex == 0)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Adjust the radius for rounded ends
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      height:
                                          4.0, // Adjust the thickness of the underline
                                      color: Colors.blue.shade300,
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
                                  style: currentIndex == 1
                                      ? TextButton.styleFrom(
                                          backgroundColor:
                                              Colors.grey.withOpacity(0.9))
                                      : null,
                                  child: const Text("    Clouds    ",
                                      style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(height: 8.0),
                                if (currentIndex == 1)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Adjust the radius for rounded ends
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
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
                        ],
                      ),
                    ),
                  ), //end of temperature and clouds navigation buttons

                  currentIndex == 0
                      //temperature chart
                      ? Expanded(
                          flex: 3,
                          child: WeatherChart(
                              hourlyWeatherList: widget.hourlyWeatherList))
                      //clouds chart
                      : Expanded(
                          flex: 3,
                          child: WeatherChart(
                            hourlyWeatherList: widget.hourlyWeatherList,
                            showClouds: true,
                          ),
                        ),
                ],
              ),
            ),
          ),
          Container(
              height: deviceHeight * 0.15,
              margin: EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("3-Hourly Weather Forecast for 5-days   ",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Icon(Icons.arrow_forward_sharp)
                ],
              )),
        ],
      ),
    );
  }
}
