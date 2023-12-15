import 'package:flutter/material.dart';
import '/constants/weather_icons.dart';
import '/view/detailed_weather/widgets/weather_details_widget.dart';

class MoreWeatherInfo extends StatelessWidget {
  final Map<String, dynamic> weatherDetails;
  const MoreWeatherInfo({required this.weatherDetails, super.key});

  @override
  Widget build(BuildContext context) {
    final name = weatherDetails.remove('name');

    final iconImage = getWeatherIcon(weatherDetails.remove('icon'));

    return Scaffold(
        // backgroundColor: Colors.black.withOpacity(0.7),
        backgroundColor: const Color.fromARGB(255, 2, 51, 94),
        appBar: AppBar(
          title: Text(
            "$name, ${weatherDetails['Country']}",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 2, 51, 94),
        ),
        body: Column(
          children: [
            Expanded(
              child: Image.asset("assets/images/weather_icons/$iconImage"),
            ),
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 05),
                //  color: Colors.black,
                child: WeatherDetailsGrid(
                  weatherDetails,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
            ),
          ],
        ));
  }
}
