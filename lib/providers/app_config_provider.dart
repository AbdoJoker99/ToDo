import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider with ChangeNotifier {
  String _appLanguage = 'en';
  ThemeMode _appTheme = ThemeMode.light;

  String get appLanguage => _appLanguage;

  ThemeMode get appTheme => _appTheme;

  AppConfigProvider() {
    _loadAppConfig();
  }

  void _loadAppConfig() async {
    final prefs = await SharedPreferences.getInstance();
    _appLanguage = prefs.getString('appLanguage') ?? 'en';
    _appTheme = prefs.getString('appTheme') == 'dark'
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  void changeAppLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    _appLanguage = language;
    await prefs.setString('appLanguage', language);
    notifyListeners();
  }

  void changeAppTheme(ThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    _appTheme = theme;
    await prefs.setString(
        'appTheme', theme == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners();
  }

  // Move the isDarkMode function inside the AppConfigProvider class
  bool isDarkMode() {
    return _appTheme == ThemeMode.dark;
  }

  void toggleAppThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      _appTheme = ThemeMode.light;
    } else {
      _appTheme = ThemeMode.dark;
    }
    notifyListeners();
  }
}
