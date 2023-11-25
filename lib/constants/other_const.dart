// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weathe_app/models/weather_model1.dart';
import 'package:weathe_app/view/today_screen.dart';

class MyBottomNavigationBarItem {
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const MyBottomNavigationBarItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}

const List<MyBottomNavigationBarItem> bottomNavigationBarItems = [
  MyBottomNavigationBarItem(
      label: "Today",
      activeIcon: Icons.calendar_today,
      inactiveIcon: Icons.calendar_today_outlined),
  MyBottomNavigationBarItem(
      label: "Hourly",
      activeIcon: Icons.lock_clock,
      inactiveIcon: Icons.lock_clock_outlined),
  MyBottomNavigationBarItem(
      label: "Daily",
      activeIcon: Icons.person,
      inactiveIcon: Icons.person_outline),
  MyBottomNavigationBarItem(
      label: "Map", activeIcon: Icons.map, inactiveIcon: Icons.map_outlined),
];
List<Widget> screens = [
  TodayScreen(),
  Container(
    child: Text("Hourly"),
  ),
  Container(
    child: Text("Daily"),
  ),
  Container(
    child: Text("Map"),
  ),
];

class TodayScreenUiData {
  String getTemp(ApiResponseModel api) {
    return api.main.temp.round().toString();
  }

  List<MainWeatherInfo> getMainWeatherInfo(ApiResponseModel api) {
    return [
      MainWeatherInfo(
        name: "Humidity",
        info: "${api.main.humidity.toString()}%",
      ),
      MainWeatherInfo(
        name: "Visibility",
        info: "${((api.visibility / 1000).round()).toString()} km",
      ),
      MainWeatherInfo(
        name: "Wind",
        info: "${((api.wind.speed * 3.6).round()).toString()} km/h",
      )
    ];
  }
}

class MainWeatherInfo {
  final String name;
  final String info;
  MainWeatherInfo({
    required this.name,
    required this.info,
  });
}
