import 'package:filmaniak/core/user_preferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  final UserPreferences _prefs = UserPreferences();

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final saved = await _prefs.getThemeApp();
    if (saved == null) {
      _isDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    } else {
      _isDarkMode = saved;
    }
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setThemeApp(_isDarkMode);
    notifyListeners();
  }
}
