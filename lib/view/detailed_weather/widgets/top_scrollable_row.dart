import 'package:flutter/material.dart';

import '../../../models/hourly_weather_model.dart';

class TopScrollableRow extends StatefulWidget {
  final int currentIndex;
  final double screenWidth;
  final List<ForecastWeatherModel> hourlyForecastList;
  final Function(int) onTap;
  final bool isDaily;
  const TopScrollableRow({
    super.key,
    required this.currentIndex,
    required this.screenWidth,
    required this.hourlyForecastList,
    required this.onTap,
    required this.isDaily,
  });

  @override
  State<TopScrollableRow> createState() => _TopScrollableRowState();
}

class _TopScrollableRowState extends State<TopScrollableRow> {
  late ScrollController _scrollController;
  late double offset;
  late int currentIndex;
  var isInitial = true;
  @override
  void initState() {
    super.initState();

    currentIndex = widget.currentIndex;

    _scrollController = ScrollController();
    currentIndex = widget.currentIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animateToOffset(index: currentIndex);
      isInitial = false;
    });
  }

  void animateToOffset({required int index}) {
    _scrollController.animateTo(
      index * widget.screenWidth * 0.15,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    currentIndex = widget.currentIndex;
    if (!isInitial) {
      animateToOffset(index: currentIndex);
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Container(
        //to show almost 7-8 hours
        width: widget.hourlyForecastList.length *
            MediaQuery.of(context).size.width *
            0.15,
        padding: const EdgeInsets.only(left: 10),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.hourlyForecastList
                .asMap()
                .entries
                .map((MapEntry<int, ForecastWeatherModel> e) {
              return Expanded(
                //to allocate space as per the length of the word
                flex:
                    widget.isDaily ? e.value.day!.length : e.value.hour!.length,
                child: GestureDetector(
                  onTap: () {
                    animateToOffset(index: e.key);
                    // _scrollController.animateTo(
                    //     e.key.toDouble() * widget.screenWidth * 0.12,
                    //     duration: const Duration(seconds: 1),
                    //     curve: Curves.easeOut);
                    widget.onTap(e.key);
                    setState(() {
                      currentIndex = e.key;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 5.0),

                    //round corners
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentIndex == e.key
                          ? Colors.purple
                          : Colors.transparent.withOpacity(0.2),
                    ),
                    alignment: Alignment.center,

                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: !widget.isDaily
                                ? "${e.value.hour!.split(' ')[0]}:00\n"
                                : e.value.day!,
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                        TextSpan(
                            text: !widget.isDaily
                                ? e.value.hour!.split(' ')[1].toLowerCase()
                                : "",
                            style: const TextStyle(fontSize: 15)),
                        if (e.key == widget.currentIndex)
                          const TextSpan(
                              text: "\n .",
                              style: TextStyle(color: Colors.blue, fontSize: 5))
                      ]),
                    ),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
