import 'package:chatapp/themes/dark_mode.dart';
import 'package:chatapp/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // by default it's the light mode
  ThemeData _themeData = lightMode;

  // getter for themeData
  ThemeData get themeDate => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  // setter for themeData
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
