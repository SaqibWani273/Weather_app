import 'package:flutter/material.dart';

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
      activeIcon: Icons.calendar_today_sharp,
      inactiveIcon: Icons.calendar_today_outlined),
  MyBottomNavigationBarItem(
      label: "Hourly",
      activeIcon: Icons.lock_clock_sharp,
      inactiveIcon: Icons.lock_clock_outlined),
  MyBottomNavigationBarItem(
      label: "Daily",
      activeIcon: Icons.person,
      inactiveIcon: Icons.person_outline),
  // MyBottomNavigationBarItem(
  //     label: "Map", activeIcon: Icons.map, inactiveIcon: Icons.map_outlined),
];
