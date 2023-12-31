import 'dart:convert';

import 'package:bazarmilo/models/userdata.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String httpUrl = dotenv.env['API_URL'] ?? "";
  String completeUrl = "";

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<LoginProvider>(context, listen: false).username;
    completeUrl = httpUrl + "/user/datum/" + username;
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(
        currentPageIndex: 2,
      ),
      body: Column(
        children: [
          Text("Profile page"),
          SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder(
                  future: getUserData(completeUrl),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      UserData data = snapshot.data as UserData;
                      return Column(
                        children: [
                          Text(data.getFullName()),
                          Text(data.getUsername()),
                          Text(data.getEmail()),
                          Text(data.getContactNum()),
                          Text(data.getAddress()),
                          Text(data.getLicenseNum()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      Provider.of<LoginProvider>(context, listen: false)
                          .updateLoginStatus(false);
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("logout"))
              ],
            ),
          )
        ],
      ),
    );
  }
}

getUserData(String url) async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return UserData.fromJson(data);
  } else {
    throw Exception('Failed to load user data');
  }
}
