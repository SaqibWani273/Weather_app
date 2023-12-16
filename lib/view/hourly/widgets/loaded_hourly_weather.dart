import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathe_app/constants/weather_icons.dart';
import '../../../constants/other_const.dart';
import '../../../repositories/weather_repository.dart';
import '../../../view/hourly/widgets/weather_chart.dart';

import '../../../models/hourly_weather_model.dart';
import '../../../utils/date_formatter.dart';
import '../../common_widgets/transition_image_widget.dart';

class LoadedHourlyWeather extends StatefulWidget {
  final List<ForecastWeatherModel> hourlyForecastList;
  const LoadedHourlyWeather({super.key, required this.hourlyForecastList});

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

  List<String> _list = ["Temperature", "Clouds"];

  @override
  Widget build(BuildContext context) {
    final imgIcon =
        getWeatherIcon(widget.hourlyForecastList[currentIndex].weather[0].icon);
    final img = currentIndex == 0 ? imgIcon : "scattered_clouds.png";
    final deviceHeight = MediaQuery.of(context).size.height;
    final apiResponseModel =
        context.read<WeatherRepository>().currentWeatherModel!.apiResponseModel;
    final formattedDateTime =
        context.read<WeatherRepository>().dateFormatter.formattedDateTime;

    return Container(
      color: const Color.fromARGB(255, 2, 51, 94),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 15),
      height: deviceHeight,
      //used stack for bottom navigation bar
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: deviceHeight <= Devices.smallMaxHeight
                ? 0.2 * deviceHeight
                : 0.25 * deviceHeight,
            child: Column(
              children: [
                //location and date
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  "${apiResponseModel.name}, ${apiResponseModel.sys.country}",
                                ),
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
                ),
                //image,
                Expanded(
                    flex: 2,
                    child: TransitionImageWidget(
                      "assets/images/weather_icons/$img",
                      isAssetFile: true,
                    )
                    //  Image.asset(
                    //   "assets/images/$img",
                    //   fit: BoxFit.cover,
                    // ),
                    )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              //rounded corners
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
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
                    flex: deviceHeight <= Devices.smallMaxHeight ? 2 : 1,
                    child: Container(
                      // color:
                      //     const Color.fromARGB(255, 2, 51, 94).withOpacity(0.5),
                      // height: deviceHeight <= Devices.smallMaxHeight
                      //     ? 0.2 * deviceHeight
                      //     : 0.1 * deviceHeight,
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                          children: _list
                              .asMap()
                              .entries
                              .map(
                                (MapEntry<int, String> e) => Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 10,
                                        child: TextButton(
                                          onPressed: () {
                                            _changeIndex(e.key);
                                          },
                                          style: currentIndex == e.key
                                              ? TextButton.styleFrom(
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.9))
                                              : null,
                                          child: Text(e.value,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      if (currentIndex == e.key)
                                        Expanded(
                                          flex: 1,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                8.0), // Adjust the radius for rounded ends
                                            child: Container(
                                              margin: e.key == 0
                                                  ? const EdgeInsets.only(
                                                      left: 20,
                                                    )
                                                  : const EdgeInsets.only(
                                                      right: 20,
                                                    ),
                                              height:
                                                  4.0, // Adjust the thickness of the underline
                                              color: Colors.blue.shade300,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                  ), //end of temperature and clouds navigation buttons

                  currentIndex == 0
                      //temperature chart
                      ? Expanded(
                          flex: deviceHeight <= Devices.smallMaxHeight ? 5 : 4,
                          child: WeatherChart(
                              hourlyForecastList: widget.hourlyForecastList))
                      //clouds chart
                      : Expanded(
                          flex: deviceHeight <= Devices.smallMaxHeight ? 5 : 4,
                          child: WeatherChart(
                            hourlyForecastList: widget.hourlyForecastList,
                            showClouds: true,
                          ),
                        ),
                  if (currentIndex == 0)
                    Container(
                      //   color: Colors.blue.shade900.withOpacity(0.3),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Column(children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Expanded(
                                child: Text("__.__  Temp",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 15)),
                              ),
                              Expanded(
                                  child: RichText(
                                      text: const TextSpan(children: [
                                TextSpan(
                                    text: "---.---",
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 15)),
                                TextSpan(
                                  text: " Real Feel",
                                )
                              ]))),
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.water_drop_sharp,
                                      color: Colors.lightBlue.shade100,
                                    ),
                                    const Text(" Humidity",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 15)),
                                  ],
                                ),
                              )
                            ])
                      ]),
                    ),
                ],
              ),
            ),
          ),
          Container(
              height: deviceHeight <= Devices.smallMaxHeight
                  ? 0.03 * deviceHeight
                  : deviceHeight * 0.1,
              margin: const EdgeInsets.only(bottom: 100),
              child: const Row(
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
