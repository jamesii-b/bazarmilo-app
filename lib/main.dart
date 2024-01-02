import 'package:bazarmilo/provider/loginerror.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/pages/login/login.dart';
import 'package:bazarmilo/views/pages/profile/profile.dart';
import 'package:bazarmilo/views/pages/navigation/maps.dart';
import 'package:bazarmilo/views/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:bazarmilo/views/pages/dashboard/dashboard.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => LoginError(), // Include the LoginError provider
        ),
      ],
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => splashScreen(),
            '/': (context) => Dashboard(),
            '/login': (context) => loginPage(),
            '/map': (context) => MapPage(),
            '/profile': (context) => Profile(),
          },
        ),
      ),
    );
  }
}
