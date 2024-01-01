import 'package:bazarmilo/models/journey.dart';
import 'package:flutter/material.dart';

class journeyDisplay extends StatefulWidget {
  final String userID;
  const journeyDisplay({super.key, required this.userID});

  @override
  State<journeyDisplay> createState() => _journeyDisplayState();
}

class _journeyDisplayState extends State<journeyDisplay> {
  late Future<journeyModel> response;

  @override
  void initState() {
    getJourneyData journeyDataCal = getJourneyData();
    response = journeyDataCal.journeyDataAPIcall(widget.userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<journeyModel>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Row(
            children: [
              Text("From: ${snapshot.data!.from}"),
              Text("To: ${snapshot.data!.to}"),
            ],
          );
        }
      },
    );
  }
}
