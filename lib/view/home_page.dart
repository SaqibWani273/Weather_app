import 'package:flutter/material.dart';
import 'package:weathe_app/constants/other_const.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: true,
          currentIndex: index,
          onTap: changeIndex,
          items: bottomNavigationBarItems
              .map((MyBottomNavigationBarItem item) => BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon: Icon(item.inactiveIcon),
                  label: item.label,
                  activeIcon: Icon(item.activeIcon)))
              .toList(),
        ),
        body: screens[index]);
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  void changeIndex(int index) {
    setState(() {
      this.index = index;
    });
  }

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.blue,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      currentIndex: index,
      onTap: changeIndex,
      items: bottomNavigationBarItems
          .map((MyBottomNavigationBarItem item) => BottomNavigationBarItem(
              backgroundColor: Colors.transparent,
              icon: Icon(item.inactiveIcon),
              label: item.label,
              activeIcon: Icon(item.activeIcon)))
          .toList(),
    );
  }
}
