import 'package:flutter/material.dart';
import 'package:weathe_app/constants/other_const.dart';

import '../hourly/hourly_screen.dart';
import '../today/screens/today_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void changeIndex(int index) {
    setState(() {
      this.index = index;
    });
  }

  var index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[index],
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              elevation: 2,
              selectedItemColor: Colors.black.withOpacity(0.6),
              unselectedItemColor: Colors.white,
              showUnselectedLabels: true,
              currentIndex: index,
              onTap: changeIndex,
              items: bottomNavigationBarItems
                  .map((MyBottomNavigationBarItem item) =>
                      BottomNavigationBarItem(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          icon: Icon(item.inactiveIcon),
                          label: item.label,
                          activeIcon: Icon(item.activeIcon)))
                  .toList(),
            ),
          ),
        ],
      ),
    );

    // screens[index]);
  }
}

List<Widget> screens = [
  const TodayScreen(),
  const HourlyScreen(),
  Container(
    child: const Text("Daily"),
  ),
  Container(
    child: const Text("Map"),
  ),
];
