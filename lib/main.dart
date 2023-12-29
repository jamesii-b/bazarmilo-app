import 'package:bazarmilo/views/pages/authentication/authentication.dart';
import 'package:bazarmilo/views/pages/profile/profile.dart';
import 'package:bazarmilo/views/pages/navigation/maps.dart';
import 'package:flutter/material.dart';
import 'package:bazarmilo/views/pages/dashboard/dashboard.dart';

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
          '/': (context) => Authentication(),
          '/home': (context) => Dashboard(),
          '/map': (context) => mapPage(),
          '/profile': (context) => profile(),
        },
      ),
    );
  }
}
