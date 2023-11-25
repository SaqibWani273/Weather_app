import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weathe_app/view/search_weather.dart';

import '../../constants/other_const.dart';
import '../../view_model/weather_bloc/weather_bloc.dart';
import '../home_page.dart';

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
                  image: NetworkImage(widget.state.weatherModel.imageUrl),
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
                  backgroundColor: Colors.white.withOpacity(0.1),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(children: [
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
                    Column(children: [
                      Text(
                        apiResponseModel.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                          )
                        ],
                      ),
                    ]),
                    Spacer(),
                    //to rotate the text from bottom to top
                    RotatedBox(
                        quarterTurns: 3,
                        child: Text(apiResponseModel.weather[0].description))
                  ],
                ),
              )),
          //main weather info
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: mainWeatherInfo
                    .asMap()
                    .entries
                    .map((mapEntry) => Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              // if (mapEntry.key != mainWeatherInfo.length - 1)
                              //   Spacer(),
                              // // if (mapEntry.key != mainWeatherInfo.length - 1)
                              // Expanded(
                              //     flex: 2,
                              //     child: Text(
                              //       "|",
                              //       style: TextStyle(fontSize: 30),
                              //     )),
                            ],
                          ),
                        )))
                    .toList(),
                //  [
                //   Expanded(
                //     child: Column(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           "${state.weatherModel.apiResponseModel.main.humidity}%",
                //         ),
                //         Text("humidity"),
                //       ],
                //     ),
                //   ),
                //   Expanded(
                //     child: Column(children: [
                //       Text(
                //         "${state.weatherModel.apiResponseModel.visibility / 1000}km",
                //       ),
                //       Text("visibility"),
                //     ]),
                //   ),
                //   Expanded(
                //       child: Column(children: [
                //     Text(
                //       "${state.weatherModel.apiResponseModel.wind.speed * 3.6}km/h",
                //     ),
                //     Text("wind"),
                //   ]))
                // ],
              ),
            ),
          ),
          Positioned(
              bottom: 0, right: 0, left: 0, child: MyBottomNavigationBar()),
          if (widget.state.weatherModel.lottieUrl != null)
            Lottie.network(widget.state.weatherModel.lottieUrl!, height: 500),
        ]),
      ),
    );
  }
}
