import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  LatLng? _routePoint; // Use nullable LatLng for a single point

  LatLng? get routePoint => _routePoint;

  MapProvider() {
    _routePoint = null;
  }

  void updateCoordinate(LatLng newCoordinate) {
    _routePoint = newCoordinate;
    notifyListeners();
  }

  void clearCoordinate() {
    _routePoint = null;
    notifyListeners();
  }
}
