import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/pages/login/login.dart';
import 'package:bazarmilo/views/pages/profile/profile.dart';
import 'package:bazarmilo/views/pages/navigation/maps.dart';
import 'package:flutter/material.dart';
import 'package:bazarmilo/views/pages/dashboard/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
   await dotenv.load();
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
      ],
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          initialRoute: '/',
          routes: {
            '/': (context) => Dashboard(),
            '/login': (context) => loginPage(),
            '/map': (context) => mapPage(),
            '/profile': (context) => profile(),
          },
        ),
      ),
    );
  }
}
