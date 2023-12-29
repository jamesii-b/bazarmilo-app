import 'dart:convert';

import 'package:http/http.dart' as http;

class loginDataModel {
  String email;
  String password;
  loginDataModel({required this.email, required this.password});
}

class authentitionAPICall {
  Future<String> login(dynamic username, dynamic password) async {
    loginDataModel loginCredentials = loginDataModel(
      email: username.text,
      password: password.text,
    );

    final response = await http.post(
      Uri.parse('http://localhost:5000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(loginCredentials),
    );
    if (response.statusCode == 200) {
      return "success";
    } else if (response.statusCode == 300) {
      return "wrong credentials";
    } else {
      return "error";
    }
  }
}
