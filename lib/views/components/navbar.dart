import 'package:bazarmilo/views/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class bottomNavigationBar extends StatefulWidget {
  int currentPageIndex;
  bottomNavigationBar({super.key, required this.currentPageIndex});

  @override
  State<bottomNavigationBar> createState() => _bottomNavigationBarState();
}

class _bottomNavigationBarState extends State<bottomNavigationBar> {
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysShow;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: labelBehavior,
      selectedIndex: widget.currentPageIndex,
      onDestinationSelected: (int index) {
        setState(() {
          widget.currentPageIndex = index;
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/');
             
              break;
            case 1:
              Navigator.pushNamed(context, '/map');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        });
      },
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.travel_explore),
          label: 'Map',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person),
          icon: Icon(Icons.bookmark_border),
          label: 'Profile',
        ),
      ],
    );
  }
}
