import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  void initState() {
    navigatetohome();
    // TODO: implement initState
    super.initState();
  }

  navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3500), () {});
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lottie/splash.json'),
          Text(
            "Bazarmilo",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontFamily: "Arbutus Slab"),
          ),
          Text(
            "A Logistics Solution for You",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontFamily: "Arbutus Slab",
            ),
          ),
        ],
      ),
    );
  }
}
