import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/hourly_weather_model.dart';
import '../../view/detailed_weather/widgets/top_scrollable_row.dart';

import '../../repositories/weather_repository.dart';
import 'widgets/weather_details_widget.dart';

class DetailedWeather extends StatefulWidget {
  final bool isHourly;
  final List<ForecastWeatherModel> hourlyForecastList;
  final int currentIndex;
  final double screenWidth;
  //to do : add daily weather
//  final List<DailyWeatherModel>? dailyWeatherList;
  const DetailedWeather({
    required this.isHourly,
    required this.screenWidth,
    required this.hourlyForecastList,
    required this.currentIndex,
    super.key,
  });

  @override
  State<DetailedWeather> createState() => _DetailedWeatherState();
}

class _DetailedWeatherState extends State<DetailedWeather> {
  late ScrollController _mainScrollController;

  late double mainScrollOffset;
  late PageController _pageController;
  late int currentTopIndex;
  late String locationName;
  // late double topRowOffset;
  @override
  void initState() {
    super.initState();
    _mainScrollController = ScrollController();
    _pageController = PageController(
      initialPage: widget.currentIndex,
    );
    currentTopIndex = widget.currentIndex;
    locationName = context
        .read<WeatherRepository>()
        .currentWeatherModel!
        .apiResponseModel
        .name;
    //Offset is the displacement (or destination position)

    //main item's width = screen width
    mainScrollOffset = widget.currentIndex * widget.screenWidth;

    _pageController.addListener(() {
      if (_pageController.page!.round() == _pageController.page) {
        setState(() {
          currentTopIndex = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _mainScrollController.dispose();

    super.dispose();
  }

  void animateToOffset({required double offset}) {
    _pageController.animateTo(offset,
        duration: const Duration(seconds: 1), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.7),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: [
              Text(
                locationName,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                widget.isHourly ? "Hourly Weather" : "Daily Weather",
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(children: [
          Expanded(
            flex: 1,
            child: TopScrollableRow(
                currentIndex: currentTopIndex,
                screenWidth: widget.screenWidth,
                hourlyForecastList: widget.hourlyForecastList,
                isDaily: false,
                onTap: (index) {
                  animateToOffset(
                      offset: index.toDouble() * widget.screenWidth);
                  // _pageController.jumpToPage(index);
                }),
          ),
          Expanded(
              flex: 8,
              child: PageView.builder(
                itemCount: widget.hourlyForecastList.length,
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return WeatherDetailWidget(
                      hourlyForecastList: widget.hourlyForecastList,
                      index: index);
                },
              )),
        ]),
      ),
    );
  }
}
