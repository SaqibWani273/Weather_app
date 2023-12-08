import 'package:flutter/material.dart';
import 'package:weathe_app/constants/hourly_consts/detailed_hourly_const.dart';
import 'package:weathe_app/utils/date_formatter.dart';

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
    final currentHour = hourlyWeatherList[index];
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   " ${hourlyWeatherList[index].main.temp}",
                  //   style: const TextStyle(color: Colors.black),
                  // ),
                  //icon and date
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Stack(
                        // alignment: Alignment.centerRight,
                        children: [
                          Column(
                            children: [
                              //to do : add icon or image dynamically based on weather condition
                              Icon(
                                Icons.nightlight_round_outlined,
                                color: Colors.yellow,
                                size: 60,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${currentHour.main.temp}°"),
                              Text(currentHour.weather[0].description),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child:
                          WeatherDetailsGrid(getMainHourDetails(currentHour))),
                ]),
          ),
          Positioned(
              child: Text(
                DateFormatter().dayAndMonth(currentHour.dt_txt),
                style: TextStyle(fontSize: 15),
              ),
              top: 10,
              left: 5),
        ],
      ),
    );
  }
}

class WeatherDetailsGrid extends StatelessWidget {
  final Map<String, dynamic> weatherDetails;

  WeatherDetailsGrid(this.weatherDetails);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: weatherDetails.length,
      itemBuilder: (context, index) {
        final key = weatherDetails.keys.elementAt(index);
        final value = weatherDetails[key];

        return FittedBox(
          child: Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    key,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
