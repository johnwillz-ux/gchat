import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Satoshi',
        ),
    primaryTextTheme: ThemeData.dark().primaryTextTheme.apply(
          fontFamily: 'Satoshi',
        ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark,
    ),
  );

  final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Satoshi',
        ),
    primaryTextTheme: ThemeData.light().primaryTextTheme.apply(
          fontFamily: 'Satoshi',
        ),
    scaffoldBackgroundColor: AppColors.kBg2Color,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.light,
    ),
  );

  ThemeData _themeData = ThemeData();
  ThemeData getTheme() => _themeData;

  ThemeNotifier({required bool isDark}) {
    _themeData = darkTheme;
    if (!isDark) {
      _themeData = lightTheme;
      notifyListeners();
    }
  }

  void toggleThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    if (_themeData == darkTheme) {
      _themeData = lightTheme;
      log('light-mode');
      prefs.setBool('isDarkMode', false);
    } else {
      _themeData = darkTheme;
      log('dark-mode');
      prefs.setBool('isDarkMode', true);
    }
    notifyListeners();
  }
}
