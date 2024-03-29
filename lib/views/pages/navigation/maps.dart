import 'dart:async';

import 'package:bazarmilo/const/others.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/provider/mapProvider.dart';
import 'package:bazarmilo/views/pages/login/components/displayprompt.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 1, //distance in meter
  );
  List<LatLng> routpoints = [];
  LatLng? userLocation;
  late StreamSubscription<Position> _locationSubscription;
  late IOWebSocketChannel _channel;
  @override
  void initState() {
    super.initState();
    routpoints = [
      Provider.of<MapProvider>(context, listen: false).routePoint ??
          LatLng(27.6197888, 85.5388073),
    ];
    try {
      _channel = IOWebSocketChannel.connect(WEBSOCKET_URL);
      print("connected to server\n ");
    } catch (e) {
      print("cant connect to server \n ");
      print(e);
    }
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);

    // getUserLocation();
    calculateRoute();
    _locationSubscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
        _sendLocationToServer(userLocation!, loginProvider.username);
      });
    });
  }

  void _sendLocationToServer(LatLng location, String? username) {
    print("\n \n sending to server \n");
    // Assuming the server expects and sends messages in JSON format
    final message = jsonEncode({
      'latitude': location.latitude,
      'longitude': location.longitude,
      'username': username ?? 'defaultUsername',
    });
    _channel.sink.add(message);
  }

  void getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else {
      try {
        Position? currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        if (currentLocation != null) {
          setState(() {
            userLocation =
                LatLng(currentLocation.latitude, currentLocation.longitude);
          });
        } else {
          displayPrompt(
              context, "Invalid", "Please turn on your location\n \n");
          // Handle the case where user location is not available
        }
      } catch (e) {
        displayPrompt(context, "Invalid", "Please turn on your location\n \n");
        // Handle exceptions (e.g., PlatformException) related to geolocation
        print('Error getting location: $e');
      }
    }
  }

  void calculateRoute() async {
    print("Calculating route\n \n \n");
    if (userLocation == null) {
      getUserLocation();
      // Handle the case where user location is not available
      return;
    }

    var v1 = userLocation!.latitude;
    var v2 = userLocation!.longitude;
    var v3 = routpoints[0].latitude;
    var v4 = routpoints[0].longitude;

    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/$v2,$v1;$v4,$v3?steps=true&annotations=true&geometries=geojson&overview=full');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          routpoints = [];
          var ruter =
              jsonDecode(response.body)['routes'][0]['geometry']['coordinates'];
          for (int i = 0; i < ruter.length; i++) {
            var reep = ruter[i].toString();
            reep = reep.replaceAll("[", "");
            reep = reep.replaceAll("]", "");
            var lat1 = reep.split(',');
            var long1 = reep.split(",");
            routpoints.add(
              LatLng(double.parse(lat1[1]), double.parse(long1[0])),
            );
          }
          print(routpoints);
        });
      } else {
        // Handle the error, perhaps by showing a message to the user
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions related to the HTTP request
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        // centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          center: userLocation ?? LatLng(27.6197888, 85.5388073),
          zoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          PolylineLayer(
            polylineCulling: false,
            polylines: [
              Polyline(points: routpoints, color: Colors.black, strokeWidth: 3),
            ],
          ),
          MarkerLayer(
            markers: [
              if (userLocation != null)
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: userLocation!,
                  builder: (ctx) => Icon(
                    Icons.person_pin,
                    color: Colors.blue,
                  ),
                ),
              if (routpoints.isNotEmpty)
                Marker(
                  width: 50.0,
                  height: 50.0,
                  point: routpoints.last,
                  builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          calculateRoute();
        },
        child: Icon(Icons.directions),
      ),
    );
  }
}
