import 'dart:async';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isOnline = false;

  String firstName = "John";

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkLoginStatus(context);
    });
    super.initState();
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    if (!loginProvider.isLogin) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomNavigationBar(currentPageIndex: 0),
        body: Text("dashboard"));
  }
}

