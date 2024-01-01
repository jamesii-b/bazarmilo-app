class WebsocketLocation {
  final double latitude;
  final double longitude;
  final bool isOnline;

  WebsocketLocation(this.latitude, this.longitude, this.isOnline);

  Map<String, dynamic> getLocation() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "isOnline": isOnline,
    };
  }
}
