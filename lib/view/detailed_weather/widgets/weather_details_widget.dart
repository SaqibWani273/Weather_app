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
                                currentHour.sys.partOfDay == 'd'
                                    ? Icons.wb_sunny_outlined
                                    : Icons.nightlight_round_outlined,
                                color: Colors.yellow,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text("${currentHour.main.temp}°"),
                              Text(currentHour.weather[0].description),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 8,
                      child:
                          WeatherDetailsGrid(getMainHourDetails(currentHour))),
                ]),
          ),
          Positioned(
              top: 10,
              left: 5,
              child: Text(
                DateFormatter().dayAndMonth(currentHour.dt_txt),
                style: const TextStyle(fontSize: 15),
              )),
        ],
      ),
    );
  }
}

class WeatherDetailsGrid extends StatelessWidget {
  final Map<String, dynamic> weatherDetails;

  const WeatherDetailsGrid(this.weatherDetails, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 2.0,
        ),
        //  physics: const NeverScrollableScrollPhysics(),
        itemCount: weatherDetails.length,
        itemBuilder: (context, index) {
          final key = weatherDetails.keys.elementAt(index);
          final value = weatherDetails[key];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      key,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.grey.shade400),
                    ),
                  ),
                ),
                // SizedBox(height: 4.0),
                Expanded(
                  //  flex: 1,
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey.shade200),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
