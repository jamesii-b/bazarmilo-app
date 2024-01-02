class DeliveryData {
  String date;
  String delivered;
  String id;
  String latitudeFrom;
  String latitudeTo;
  String longitudeFrom;
  String longitudeTo;
  String productID;
  String username;
  String vehicleNumber;

  DeliveryData({
    required this.date,
    required this.delivered,
    required this.id,
    required this.latitudeFrom,
    required this.latitudeTo,
    required this.longitudeFrom,
    required this.longitudeTo,
    required this.productID,
    required this.username,
    required this.vehicleNumber,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) {
    return DeliveryData(
      date: json['date'],
      delivered: json['delivered'] == null ? 0 : json['delivered'],
      id: json['id'],
      latitudeFrom: json['latitudeFrom'],
      latitudeTo: json['latitudeTo'],
      longitudeFrom: json['longitudeFrom'],
      longitudeTo: json['longitudeTo'],
      productID: json['productID'],
      username: json['username'],
      vehicleNumber: json['vehicleNumber'],
    );
  }

  String getDate() => date;

  String getDelivered() => delivered;

  String getId() => id;

  String getLatitudeFrom() => latitudeFrom;

  String getLatitudeTo() => latitudeTo;

  String getLongitudeFrom() => longitudeFrom;

  String getLongitudeTo() => longitudeTo;

  String getProductID() => productID;

  String getUsername() => username;

  String getVehicleNumber() => vehicleNumber;
  @override
  String toString() {
    return 'DeliveryData {'
        'date: $date, '
        'delivered: $delivered, '
        'id: $id, '
        'latitudeFrom: $latitudeFrom, '
        'latitudeTo: $latitudeTo, '
        'longitudeFrom: $longitudeFrom, '
        'longitudeTo: $longitudeTo, '
        'productID: $productID, '
        'username: $username, '
        'vehicleNumber: $vehicleNumber}';
  }
}
