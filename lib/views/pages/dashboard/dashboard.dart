import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String firstName = "John";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomNavigationBar(currentPageIndex: 0),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Hi, ${firstName}"),
              Column(
                children: [
                  Text("you are heading from"),
                  Text("Golcha to Khetan"),
                  
                ],
              )
            ],
          ),
        ));
  }
}
