import 'package:http/http.dart' as http;
import 'dart:convert';

class journeyModel {
  String from;
  String to;
  journeyModel({required this.from, required this.to});
}

class getJourneyData {
  Future<journeyModel> journeyDataAPIcall(String userID) async {
    final response = await http.get(
      Uri.parse('http://localhost:5000/api/journey/${userID}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      journeyModel journeyData = journeyModel(
        from: data["from"],
        to: data["to"],
      );
      return journeyData;
    } else {
      throw Exception('Failed to load journey data');
    }
  }
}

