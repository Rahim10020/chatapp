import 'package:chatapp/themes/dark_mode.dart';
import 'package:chatapp/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Par défaut, mode clair
  ThemeData _themeData = lightMode;

  // Getter pour themeData
  ThemeData get themeData => _themeData;

  // Getter alternatif pour plus de clarté
  ThemeData get currentTheme => _themeData;

  // Getter pour savoir si on est en mode sombre
  bool get isDarkMode => _themeData == darkMode;

  // Getter pour le ThemeMode (optionnel, pour une gestion plus avancée)
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  // Setter pour themeData
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    update(); // Equivalent de notifyListeners() mais pour GetX
  }

  // Méthode pour basculer le thème
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }

  // Méthodes supplémentaires pour plus de flexibilité
  void setLightTheme() {
    themeData = lightMode;
  }

  void setDarkTheme() {
    themeData = darkMode;
  }
}
