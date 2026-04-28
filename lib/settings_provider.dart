import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _language = 'English';
  bool _isLocationEnabled = true;

  bool get isDarkMode => _isDarkMode;
  String get language => _language;
  bool get isLocationEnabled => _isLocationEnabled;

  void toggleDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void toggleLocation(bool value) {
    _isLocationEnabled = value;
    notifyListeners();
  }
}