import 'dart:convert';

import 'package:bazarmilo/models/authentication.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String websocketUrl = dotenv.env['API_URL'] ?? "";
  String completeUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    completeUrl = websocketUrl + "/user/login";

    super.initState();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        children: [
          Text("login page"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            controller: usernameController,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'password',
            ),
            controller: passwordController,
          ),
          ElevatedButton(
            onPressed: () async {
              print(completeUrl);
              /* var newResponse =
                  await http.get(Uri.parse("http://localhost:8080")); */
              var response = await http.post(
                Uri.parse(completeUrl),
                headers: {
                  'Content-Type':
                      'application/json', // Set the content type to JSON
                },
                body: jsonEncode(LoginDataModel(
                  username: usernameController.text,
                  password: passwordController.text,
                ).getLoginModel()),
              );
              print(LoginDataModel(
                      username: usernameController.text,
                      password: passwordController.text)
                  .getLoginModel());
              print(response.body);
              if (response.statusCode == 200) {
                setState(() {
                  Navigator.pushNamed(context, '/');
                  loginProvider.updateLoginStatus(true);
                });
              } else {
                // print(newResponse.body);
                // print(newResponse.statusCode);
                print('Response status code: ${response.statusCode}');

                // Print the response body
                print('Response body: ${response.body}');
                print("faled login");
                loginProvider.updateLoginStatus(false);
              }
              // Navigate to another page if needed
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
