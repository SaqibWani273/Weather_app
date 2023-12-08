import 'package:flutter/material.dart';

import '../../../models/hourly_weather_model.dart';

class TopScrollableRow extends StatefulWidget {
  final int currentIndex;
  final double screenWidth;
  final List<HourlyWeatherModel> hourlyWeatherList;
  final Function(int) onTap;
  const TopScrollableRow({
    super.key,
    required this.currentIndex,
    required this.screenWidth,
    required this.hourlyWeatherList,
    required this.onTap,
  });

  @override
  State<TopScrollableRow> createState() => _TopScrollableRowState();
}

class _TopScrollableRowState extends State<TopScrollableRow> {
  late ScrollController _scrollController;
  late double offset;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    // width = screen width * 0.12 i.e. 12% of screen width
    offset = widget.currentIndex * widget.screenWidth * 0.12;

    _scrollController = ScrollController();
    currentIndex = widget.currentIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.animateTo(offset,
          duration: const Duration(seconds: 1), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Container(
        //to show almost 7-8 hours
        width: widget.hourlyWeatherList.length *
            MediaQuery.of(context).size.width *
            0.13,
        padding: const EdgeInsets.only(left: 10),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.hourlyWeatherList
                .asMap()
                .entries
                .map((MapEntry<int, HourlyWeatherModel> e) {
              return Expanded(
                //to allocate space as per the length of the word
                flex: e.value.hour.length,
                child: GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                        e.key.toDouble() * widget.screenWidth * 0.12,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut);
                    widget.onTap(e.key);
                    setState(() {
                      currentIndex = e.key;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: RichText(
                      text: TextSpan(
                          //text: e.value.hour.split(' ')[0],
                          style: TextStyle(
                              color: e.key == currentIndex
                                  ? Colors.purple
                                  : Colors.black),
                          children: [
                            TextSpan(
                                text: "${e.value.hour.split(' ')[0]}:00\n",
                                style: const TextStyle(
                                  fontSize: 15,
                                )),
                            TextSpan(
                                text: e.value.hour.split(' ')[1].toLowerCase(),
                                style: const TextStyle(fontSize: 15)),
                            if (e.key == widget.currentIndex)
                              const TextSpan(
                                  text: "\n .",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 5))
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
