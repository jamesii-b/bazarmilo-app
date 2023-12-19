import 'package:bazarmilo/pages/profile.dart';
import 'package:bazarmilo/pages/maps.dart';
import 'package:flutter/material.dart';
import 'package:bazarmilo/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        // use material 3
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        initialRoute: '/',
        routes: {
          '/': (context) => Dashboard(),
          '/map': (context) => const mapsPage(),
          '/profile': (context) => profile(),
        },
      ),
    );
  }
}
