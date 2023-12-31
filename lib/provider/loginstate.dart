import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  void updateLoginStatus(value) {
    _isLogin = value;
    notifyListeners();
  }
}
