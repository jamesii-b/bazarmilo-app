import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isLogin = true;
  @override
  void initState() {
    _redirectToRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder widget or any other UI you want to display
    return Scaffold(
      body: Center(
        child: Text("Authentication"),
      ),
    );
  }

  void _redirectToRoute() {
    // Use Navigator to push to another route based on the value of isLogin
    if (isLogin) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
            context, '/home'); // Replace with your route
      });
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(
            context, '/login'); // Replace with your route
      });
    }
  }
}
