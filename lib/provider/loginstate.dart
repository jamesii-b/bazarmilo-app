import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  String _username = "";
  String get username => _username;
  void updateUsername(value) {
    _username = value;
    notifyListeners();
  }

  void updateLoginStatus(value) {
    _isLogin = value;
    notifyListeners();
  }
}
