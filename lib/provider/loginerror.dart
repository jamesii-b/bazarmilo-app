import 'package:flutter/material.dart';

class LoginError extends ChangeNotifier {
  bool _showError = false;
  bool get showError => _showError;
  void updateLoginError(value) {
    _showError = value;
    notifyListeners();
  }
}
