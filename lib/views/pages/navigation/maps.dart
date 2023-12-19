import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';

class mapsPage extends StatefulWidget {
  const mapsPage({super.key});

  @override
  State<mapsPage> createState() => _mapsPageState();
}

class _mapsPageState extends State<mapsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(currentPageIndex: 1,),
      body: const Text("maps"),
    );
  }
}