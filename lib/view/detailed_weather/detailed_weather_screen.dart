import 'package:flutter/material.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';
import 'package:weathe_app/view/detailed_weather/widgets/top_scrollable_row.dart';

import 'widgets/weather_details_widget.dart';

class DetailedWeather extends StatefulWidget {
  final bool isHourly;
  final List<HourlyWeatherModel> hourlyWeatherList;
  final int currentIndex;
  final double screenWidth;
  //to do : add daily weather
//  final List<DailyWeatherModel>? dailyWeatherList;
  const DetailedWeather({
    required this.isHourly,
    required this.screenWidth,
    required this.hourlyWeatherList,
    required this.currentIndex,
    super.key,
  });

  @override
  State<DetailedWeather> createState() => _DetailedWeatherState();
}

class _DetailedWeatherState extends State<DetailedWeather> {
  late ScrollController _mainScrollController;

  late double mainScrollOffset;
  // late double topRowOffset;
  @override
  void initState() {
    _mainScrollController = ScrollController();

    super.initState();
    //Offset is the displacement (or destination position)

    //main item's width = screen width
    mainScrollOffset = widget.currentIndex * widget.screenWidth;

    //using post frame callback as we need to wait for scroll controller to be initialized
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animateToOffset(offset: mainScrollOffset);
    });
  }

  @override
  void dispose() {
    _mainScrollController.dispose();

    super.dispose();
  }

  void animateToOffset({required double offset}) {
    _mainScrollController.animateTo(offset,
        duration: const Duration(seconds: 1), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              "location name",
            ),
            Text(
              widget.isHourly ? "Hourly Weather" : "Daily Weather",
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black.withOpacity(0.7),
        child: Column(children: [
          Expanded(
            flex: 1,
            child: TopScrollableRow(
                currentIndex: widget.currentIndex,
                screenWidth: widget.screenWidth,
                hourlyWeatherList: widget.hourlyWeatherList,
                onTap: (index) {
                  animateToOffset(
                      offset: index.toDouble() * widget.screenWidth);
                }),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.hourlyWeatherList.length,
                controller: _mainScrollController,
                itemBuilder: (context, index) {
                  return WeatherDetailWidget(
                      hourlyWeatherList: widget.hourlyWeatherList,
                      index: index);
                }),
          ),
        ]),
      ),
    );
  }
}
