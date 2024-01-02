class DeliveryData {
  String date;
  String delivered;
  String id;
  String latitudeTo;
  String longitudeTo;
  String productID;
  String username;
  String vehicleNumber;

  DeliveryData({
    required this.date,
    required this.delivered,
    required this.id,
    required this.latitudeTo,
    required this.longitudeTo,
    required this.productID,
    required this.username,
    required this.vehicleNumber,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) {
    return DeliveryData(
      date: json['date'],
      delivered: json['delivered'],
      id: json['id'],
      latitudeTo: json['latitudeTo'],
      longitudeTo: json['longitudeTo'],
      productID: json['productID'],
      username: json['username'],
      vehicleNumber: json['vehicleNumber'],
    );
  }

  String getDate() => date;

  String getDelivered() => delivered;

  String getId() => id;


  double getLatitudeTo() => double.parse(latitudeTo);


  double getLongitudeTo() => double.parse(longitudeTo);

  String getProductID() => productID;

  String getUsername() => username;

  String getVehicleNumber() => vehicleNumber;
  @override
  String toString() {
    return 'DeliveryData {'
        'date: $date, '
        'delivered: $delivered, '
        'id: $id, '
        'latitudeTo: $latitudeTo, '
        'longitudeTo: $longitudeTo, '
        'productID: $productID, '
        'username: $username, '
        'vehicleNumber: $vehicleNumber}';
  }
}
