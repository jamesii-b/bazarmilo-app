import 'dart:async';
import 'dart:convert';
import 'package:bazarmilo/const/others.dart';
import 'package:bazarmilo/models/deliveryData.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/provider/mapProvider.dart';
import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
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
    getDeliveryData(completeUrl, username).then((_) {
      setState(() {});
      updateCoordinateIfToday();
    });
  }

  Future<void> getDeliveryData(String url, String username) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String localDate = DateTime.now().toString().substring(0, 10);
        print(localDate);
        List<dynamic> data = json.decode(response.body);
        print(data);
        List<DeliveryData> filteredData = data
            .where((item) =>
                item['username'] == username || item['date'] == localDate)
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

  void updateCoordinateIfToday() {
    final mapProvider = Provider.of<MapProvider>(context, listen: false);
    String today = DateTime.now().toString().substring(0, 10);

    // Check if there is data for today and set coordinate if found
    if (deliveryData.any((data) => data.getDate() == today)) {
      // Assuming there is only one data for today, you may need to modify this logic
      DeliveryData todayData =
          deliveryData.firstWhere((data) => data.getDate() == today);
      mapProvider.updateCoordinate(
          LatLng(todayData.getLatitudeTo(), todayData.getLongitudeTo()));
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
                ? groupByDate(deliveryData).entries.map((entry) {
                    String dateTitle = entry.key;
                    List<DeliveryData> dataList = entry.value;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            dateTitle,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...dataList.map((data) {
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
                                        "To: (${data.getLatitudeTo()}, ${data.getLongitudeTo()})"),
                                    Text("Product ID: ${data.getProductID()}"),
                                    Text(
                                        "Vehicle Number: ${data.getVehicleNumber()}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList()
                : [
                    SizedBox(
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    // Display a message when there is no data
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No delivery data available.",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
          ),
        ),
      ],
    );
  }

  Map<String, List<DeliveryData>> groupByDate(List<DeliveryData> dataList) {
    Map<String, List<DeliveryData>> groupedData = {};

    for (var data in dataList) {
      String date = data.getDate();
      if (isToday(date)) {
        groupedData.putIfAbsent("Today", () => []).add(data);
      } else {
        groupedData.putIfAbsent("Upcoming Dates", () => []).add(data);
      }
    }

    // Reorder the groups to show "Today" first
    groupedData = Map.fromEntries(groupedData.entries.toList()
      ..sort((a, b) => a.key == "Today" ? -1 : 1));

    return groupedData;
  }

  bool isToday(String date) {
    String today = DateTime.now().toString().substring(0, 10);
    return date == today;
  }
}
