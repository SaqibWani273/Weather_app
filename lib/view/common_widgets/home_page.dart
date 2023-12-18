import 'package:flutter/material.dart';
import 'package:weathe_app/view/daily/daily_weather_screen.dart';

import '../../constants/bottom_nav_bar_consts.dart';
import '../hourly/hourly_screen.dart';
import '../today/today_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> screens;

//to not show the bottom nav bar when loading the today screen
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screens = [
      TodayScreen(changeLoading: (val) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            isLoading = val;
          });
        });
      }),
      const HourlyScreen(),
      const DailyWeatherScreen(),
    ];
  }

  var isLoading = true;

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
          if (!isLoading)
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
  }
}
