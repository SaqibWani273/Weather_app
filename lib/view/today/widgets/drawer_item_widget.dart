import 'package:flutter/material.dart';

Map<String, IconData> drawerItems = {
  "Search Weather": Icons.search,
  "More Weather Info": Icons.nightlight_outlined,
};

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerItemWidget({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            onTap: onTap,
            title: FittedBox(child: Text(title)),
            trailing: Icon(icon),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
      ],
    );
  }
}
