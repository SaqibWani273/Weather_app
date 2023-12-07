import 'package:flutter/material.dart';

import '../../../models/hourly_weather_model.dart';

class WeatherDetailWidget extends StatelessWidget {
  const WeatherDetailWidget({
    super.key,
    required this.hourlyWeatherList,
    required this.index,
  });

  final int index;
  final List<HourlyWeatherModel> hourlyWeatherList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          " ${hourlyWeatherList[index].main.temp}",
          style: const TextStyle(color: Colors.black),
        ),
      ]),
    );
  }
}
