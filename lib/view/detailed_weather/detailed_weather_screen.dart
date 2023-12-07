import 'package:flutter/material.dart';
import 'package:weathe_app/models/hourly_weather_model.dart';
import 'package:weathe_app/view/detailed_weather/widgets/top_scrollable_row.dart';

class DetailedWeather extends StatefulWidget {
  final bool isHourly;
  final List<HourlyWeatherModel>? hourlyWeatherList;
  final int currentIndex;
  final double screenWidth;
  //to do : add daily weather
//  final List<DailyWeatherModel>? dailyWeatherList;
  const DetailedWeather({
    required this.isHourly,
    required this.screenWidth,
    this.hourlyWeatherList,
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
      //  _mainScrollController.jumpTo(713.5);
      _mainScrollController.animateTo(mainScrollOffset,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
    });
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
      body: Column(children: [
        Expanded(
          flex: 1,
          child: TopScrollableRow(
              currentIndex: widget.currentIndex,
              screenWidth: widget.screenWidth,
              hourlyWeatherList: widget.hourlyWeatherList!,
              onTap: (index) {
                _mainScrollController.animateTo(
                  index.toDouble() * widget.screenWidth,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeOut,
                );
              }),
        ),
        Expanded(
          flex: 8,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.hourlyWeatherList!.length,
              controller: _mainScrollController,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " ${widget.hourlyWeatherList![index].main.temp}",
                          style: const TextStyle(color: Colors.black),
                        ),
                      ]),
                );
              }),
        ),
      ]),
    );
  }
}
