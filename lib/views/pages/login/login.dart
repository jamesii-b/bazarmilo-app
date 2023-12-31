import 'dart:convert';

import 'package:bazarmilo/models/authentication.dart';
import 'package:bazarmilo/provider/loginstate.dart';
import 'package:bazarmilo/views/pages/login/components/displayprompt.dart';
import 'package:bazarmilo/views/pages/login/components/forgotpassword.dart';
import 'package:bazarmilo/views/pages/login/components/signinbutton.dart';
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
  String httpUrl = dotenv.env['API_URL'] ?? "";
  String completeUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    completeUrl = httpUrl + "/user/login";

    super.initState();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context, listen: false);

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.asset("assets/images/logo.png"),
            ),
            const SizedBox(
              height: 2.9,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 26),
              child: Text(
                "Sign In",
                style: TextStyle(
                    fontSize: 34.2,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Arbutus Slab'),
              ),
            ),
            const SizedBox(
              width: 84,
              child: Padding(
                padding: EdgeInsets.only(left: 26, top: 4),
                child: Divider(
                  height: 2,
                  color: Color(0xffff8d83),
                ),
              ),
            ),
            const SizedBox(
              height: 55.3,
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(
                  "Username",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 17.25,
                      fontFamily: 'Arbutus Slab'),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: TextField(
                controller: usernameController,
                decoration:const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                          0xffFF8D83), // Set the color of the underline here
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 55.3,
            ),
            Container(
              child: const Padding(
                padding: EdgeInsets.only(left: 26),
                child: Text(
                  "Password",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 17.25,
                      fontFamily: 'Arbutus Slab'),
                ),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 26.0, right: 26.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(
                          0xffFF8D83), // Set the color of the underline here
                    ),
                  ),
                ),
              ),
            ),
            const forgotPassword(),
            const SizedBox(
              height: 125,
            ),
            signInButton(
              url: completeUrl,
              username: usernameController.text,
              password: passwordController.text,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "©️ 2023 Bazarmilo",
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                      fontSize: 14,
                      fontFamily: 'Arbutus Slab'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
