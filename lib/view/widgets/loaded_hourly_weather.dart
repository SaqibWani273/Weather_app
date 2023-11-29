import 'package:flutter/material.dart';
import 'package:weathe_app/view/widgets/temp.dart';
import 'package:weathe_app/view/widgets/weather_chart.dart';

import '../../models/hourly_weather_model.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            color: Colors.blue.shade900.withOpacity(0.7),
            child: Row(children: [
              Expanded(
                child: TextButton(
                    onPressed: () {
                      _changeIndex(0);
                    },
                    child: Text(
                      "Temperature",
                    )),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () {
                      _changeIndex(1);
                    },
                    child: Text(
                      "Clouds",
                    )),
              )
            ])),
        currentIndex == 0
            ? WeatherChart(hourlyWeatherList: widget.hourlyWeatherList)
            : WeatherChart(
                hourlyWeatherList: widget.hourlyWeatherList,
                showClouds: true,
              ),
        if (currentIndex == 0)
          Container(
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                  child: Text("___.___  Temperauture",
                      style: TextStyle(color: Colors.white70, fontSize: 15)),
                ),
                Expanded(
                  child: Text("----.----  Real Feel",
                      style: TextStyle(color: Colors.green, fontSize: 15)),
                )
              ])
            ]),
          )
      ],
    );
  }
}
