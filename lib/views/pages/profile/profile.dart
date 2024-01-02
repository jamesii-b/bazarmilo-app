import 'dart:convert';

import 'package:bazarmilo/const/others.dart';
import 'package:bazarmilo/models/userdata.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/components/navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String httpUrl = API_URL;
  late String completeUrl;

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<LoginProvider>(context, listen: true).username;
    completeUrl = httpUrl + "/user/datum/" + username;
    print(completeUrl);

    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(currentPageIndex: 2),
      
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Your CircleAvatar widget with an image from the network or local assets
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: getUserData(completeUrl),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserData data = snapshot.data as UserData;
                  return Column(
                    children: [
                      Text(
                        data.getUsername(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      itemProfile('Name', data.getFullName(), Icons.person),
                      const SizedBox(height: 10),
                      itemProfile('Phone', data.getContactNum(), Icons.phone),
                      const SizedBox(height: 10),
                      itemProfile(
                          'Address', data.getAddress(), Icons.location_city),
                      const SizedBox(height: 10),
                      itemProfile('Email', data.getEmail(), Icons.mail),
                      const SizedBox(height: 10),
                      itemProfile('License', data.getLicenseNum(),
                          Icons.card_membership),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                          onPressed: () {
                            Provider.of<LoginProvider>(context, listen: false)
                                .updateLoginStatus(false);
                            Navigator.pushReplacementNamed(context, '/login');
                            // Handle Edit Profile button press
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text('Logout'),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.deepOrange.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
        tileColor: Colors.white,
      ),
    );
  }

  Future<UserData> getUserData(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return UserData.fromJson(data);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
