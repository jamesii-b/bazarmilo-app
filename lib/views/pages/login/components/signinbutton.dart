import 'dart:convert';

import 'package:bazarmilo/models/authentication.dart';
import 'package:bazarmilo/provider/loginerror.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class signInButton extends StatefulWidget {
  final String url;
  final String username;
  final String password;
  signInButton(
      {super.key,
      required this.url,
      required this.username,
      required this.password});

  @override
  State<signInButton> createState() => _signInButtonState();
}

class _signInButtonState extends State<signInButton> {
  bool showInvalid = false;
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);
    var loginErrorProvider = Provider.of<LoginError>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            try {
              var response = await http.post(
                Uri.parse(widget.url),
                headers: {
                  'Content-Type':
                      'application/json', // Set the content type to JSON
                },
                body: jsonEncode(LoginDataModel(
                  username: widget.username,
                  password: widget.password,
                ).getLoginModel()),
              );
              if (response.statusCode == 200) {
                setState(() {
                  Navigator.pushNamed(context, '/');
                  loginProvider.updateLoginStatus(true);
                  loginProvider.updateUsername(widget.username.toString());
                });
              } else {
                loginErrorProvider.updateLoginError(true);
                // print(newResponse.body);
                // print(newResponse.statusCode);
                print('Response status code: ${response.statusCode}');

                // Print the response body
                print('Response body: ${response.body}');
                print("faled login");
                setState(() {});
              }
            } catch (e) {
              loginErrorProvider.updateLoginError(true);
              setState(() {});
              print(e);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffFF8D83), // Background color
            minimumSize: const Size(127.0, 50.0), // Width and height
          ),
          child: const Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.25,
              fontFamily: 'Arbutus Slab',
            ),
          ),
        ),
      ],
    );
  }
}
