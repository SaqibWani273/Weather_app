import 'package:flutter/material.dart';
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
