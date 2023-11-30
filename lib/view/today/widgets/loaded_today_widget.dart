import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathe_app/utils/get_formatted_datetime.dart';
import 'package:weathe_app/view/search_weather.dart';
import 'package:weathe_app/view/widgets/loading_weather.dart';

import '../../../constants/other_const.dart';
import '../../../view_model/weather_bloc/weather_bloc.dart';
import '../../home_page.dart';

//to do: change the  name of the class
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
    final apiResponseModel = widget.state.weatherModel.apiResponseModel;
    final temp = TodayScreenUiData().getTemp(apiResponseModel);
    final List<MainWeatherInfo> mainWeatherInfo =
        TodayScreenUiData().getMainWeatherInfo(apiResponseModel);
    final formattedDateTime = getFormattedDateTime(apiResponseModel.timezone);

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
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.network(
                    widget.state.weatherModel.imageUrl,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) {
                        return child;
                      }
                      return LoadingWeather();
                    },
                  ).image,
                  fit: BoxFit.fill),
            ),
          ),
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
                  ))),

          //      Positioned(top: 40, child: SearchWeather()),
          //temp, city name, weather description
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
                            SizedBox(
                              height: 10,
                            ),
                            FittedBox(
                              child: Text(
                                formattedDateTime,
                                textScaleFactor: 1.8,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ]),
                    ),
                    Spacer(),
                    //to rotate the text from bottom to top
                    // RotatedBox(
                    //     quarterTurns: 3,
                    //     child: Text(apiResponseModel.weather[0].description))
                  ],
                ),
              )),

          //main weather info
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(
              //       color: Colors.white,
              //       width: 3,
              //     )),
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              temp,
                              style: TextStyle(
                                fontSize: 70,
                              ),
                            ),
                            Text(
                              "O",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "C",
                              style: TextStyle(
                                  fontSize: 70, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Expanded(
                          //   flex: 2,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/cloud.png",
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(apiResponseModel.weather[0].description),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
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

          if (widget.state.weatherModel.lottieUrl != null)
            Lottie.network(widget.state.weatherModel.lottieUrl!, height: 500),
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
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height,
                child: Drawer(
                  backgroundColor: Colors.grey.withOpacity(0.8),
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
                        tileColor: Colors.white,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchWeather(),
                              ));
                        },
                        title: Text("Search Weather"),
                        trailing: Icon(Icons.search),
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
