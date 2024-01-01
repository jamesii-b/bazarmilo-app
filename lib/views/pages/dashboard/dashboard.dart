import 'dart:async';
import 'dart:convert';

import 'package:bazarmilo/const/others.dart';
import 'package:bazarmilo/models/deliveryData.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String username = "";
  String httpUrl = API_URL;
  String completeUrl = "";
  late List<DeliveryData> deliveryData = [];

  @override
  void initState() {
    super.initState();

    completeUrl = "$httpUrl/tasks";
    username = Provider.of<LoginProvider>(context, listen: false).username;
    // Use the then method to handle the asynchronous work
    getDeliveryData(completeUrl, username).then((_) {
      // This will be called after the asynchronous call is complete
      // Set state here if needed
      setState(() {});
    });
  }

  Future<void> getDeliveryData(String url, String username) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String localDate = DateTime.now().toString().substring(0, 10);
        print(localDate);
        List<dynamic> data = json.decode(response.body);
        List<DeliveryData> filteredData = data
            .where((item) =>
                item['username'] == username &&
                item['date'] ==
                    localDate) // You can customize the date comparison
            .map((item) => DeliveryData.fromJson(item))
            .toList();
        // Set the state after the data is filtered
        setState(() {
          deliveryData = filteredData;
        });
        // Print each instance's details
        deliveryData.forEach((data) {
          print(data);
        });
      } else {
        throw Exception('Failed to load travel data');
      }
    } catch (e) {
      print('Error fetching travel data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(currentPageIndex: 0),
      body: Column(
        children: [
          DisplayInfo(
            deliveryData: deliveryData,
          ),
        ],
      ),
    );
  }
}

class DisplayInfo extends StatefulWidget {
  late List<DeliveryData> deliveryData = [];

  DisplayInfo({super.key, required this.deliveryData});

  @override
  State<DisplayInfo> createState() => _DisplayInfoState();
}

class _DisplayInfoState extends State<DisplayInfo> {
  @override
  Widget build(BuildContext context) {
    final deliveryData = widget.deliveryData;

    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            children: (deliveryData != null && deliveryData.isNotEmpty)
                ? deliveryData.map((data) {
                    print(data.getDate());
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: ListTile(
                          title: Text("Date: ${data.getDate()}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delivered: ${data.getDelivered()}"),
                              Text("ID: ${data.getId()}"),
                              Text(
                                  "From: (${data.getLatitudeFrom()}, ${data.getLongitudeFrom()})"),
                              Text(
                                  "To: (${data.getLatitudeTo()}, ${data.getLongitudeTo()})"),
                              Text("Product ID: ${data.getProductID()}"),
                              Text("Username: ${data.getUsername()}"),
                              Text(
                                  "Vehicle Number: ${data.getVehicleNumber()}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList()
                : [
                    // Display a message when there is no data
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("No delivery data available."),
                    ),
                  ],
          ),
        ),
      ],
    );
  }
}
