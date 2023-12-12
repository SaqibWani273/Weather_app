import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weathe_app/repositories/weather_repository.dart';
import '../../../constants/today_screen_consts.dart';
import '../../../utils/date_formatter.dart';
import '../screens/search_weather.dart';

import '../../../view_model/weather_bloc/weather_bloc.dart';
import 'transition_image_widget.dart';

class LoadedTodayWidget extends StatefulWidget {
  const LoadedTodayWidget({
    super.key,
    required this.state,
  });

  final WeatherLoadedState state;

  @override
  State<LoadedTodayWidget> createState() => _LoadedTodayWidgetState();
}

class _LoadedTodayWidgetState extends State<LoadedTodayWidget> {
  var showDrawer = false;
  @override
  Widget build(BuildContext context) {
    final apiResponseModel = widget.state.currentWeatherModel.apiResponseModel;
    final temp = TodayScreenUiData().getTemp(apiResponseModel);
    final List<MainWeatherInfo> mainWeatherInfo =
        TodayScreenUiData().getMainWeatherInfo(apiResponseModel);
    final DateFormatter dateFormatter =
        context.read<WeatherRepository>().dateFormatter;
    dateFormatter.setFormattedDateTime = apiResponseModel.timezone;
    context.read<WeatherRepository>().dateFormatter.setTimeZoneOffset =
        apiResponseModel.timezone;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (showDrawer == true) {
            showDrawer = false;
          }
        });
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(children: [
          //bg image
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.grey,
            child: TransitionImageWidget(
              widget.state.currentWeatherModel.imageUrl,
              isAssetFile: false,
            ),
          ),
          //menu icon
          Positioned(
              top: 30,
              left: 20,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      showDrawer = true;
                    });
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))),
//location name and date
          Positioned(
              top: 100,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
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
                                dateFormatter.formattedDateTime,
                                textScaler: const TextScaler.linear(1.8),
                              ),
                            ),
                          ]),
                    ),
                    const Spacer(),
                  ],
                ),
              )),

          //main weather info
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                temp,
                                style: const TextStyle(
                                  fontSize: 70,
                                ),
                              ),
                              const Text(
                                "O",
                                style: TextStyle(fontSize: 20),
                              ),
                              const Text(
                                "C",
                                style: TextStyle(
                                    fontSize: 70, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/cloud.png",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(apiResponseModel.weather[0].description),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: mainWeatherInfo
                          .asMap()
                          .entries
                          .map((mapEntry) => Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        //  mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                mapEntry.value.info,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                mapEntry.value.name,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
//to show some animation for rain or snow
          if (widget.state.currentWeatherModel.lottieUrl != null)
            Lottie.network(widget.state.currentWeatherModel.lottieUrl!,
                height: 500),

//custom drawer
          if (showDrawer)
            Positioned(
              top: 0,
              left: 0,
              bottom: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                transform:
                    Matrix4.translationValues(showDrawer ? 0 : -250, 0, 0),
                //   color: Colors.transparent,
                color: const Color.fromRGBO(10, 47, 91, 255),
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                child: Drawer(
                  backgroundColor: const Color.fromARGB(255, 2, 51, 94),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(children: [
                      DrawerHeader(
                        child: Image.asset("assets/images/cloud.png"),
                        // decoration: BoxDecoration(
                        //   color: Colors.grey.withOpacity(0.7),
                        // ),
                      ),
                      ListTile(
                        //  tileColor: Colors.white,
                        tileColor: Colors.blueGrey,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchWeather(),
                              ));
                        },
                        title: const Text("Search Weather"),
                        trailing: const Icon(Icons.search),
                      )
                    ]),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
