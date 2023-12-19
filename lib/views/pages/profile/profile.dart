import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      bottomNavigationBar: bottomNavigationBar(currentPageIndex: 2,),
      body: const Text("profile"),
    );
  }
}