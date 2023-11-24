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
                  backgroundColor: Colors.green,
                  icon: Icon(item.inactiveIcon),
                  label: item.label,
                  activeIcon: Icon(item.activeIcon)))
              .toList(),
        ),
        body: screens[index]);
  }
}
