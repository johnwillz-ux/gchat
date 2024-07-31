/// A notifier class responsible for managing the application's theme.
///
/// This class provides a simple way to switch between light and dark themes.
/// It uses the `SharedPreferences` package to persist the theme preference.
///
/// Example:
///
/// ```dart
/// void main() async {
///   final prefs = await SharedPreferences.getInstance();
///   final isDarkMode = prefs.getBool('isDarkMode') ?? false;
///
///   runApp(
///     ChangeNotifierProvider<ThemeNotifier>(
///       create: (_) => ThemeNotifier(isDark: isDarkMode),
///       child: MyApp(),
///     ),
///   );
/// }
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     final themeNotifier = context.watch<ThemeNotifier>();
///
///     return MaterialApp(
///       title: 'G Chat',
///       theme: themeNotifier.getTheme(),
///       home: Scaffold(
///         appBar: AppBar(
///           title: Text('G Chat'),
///         ),
///         body: Center(
///           child: ElevatedButton(
///             onPressed: themeNotifier.toggleThemeMode,
///             child: Text('Toggle Theme'),
///           ),
///         ),
///       ),
///     );
///   }
/// }
/// ```
///
/// See also:
///
/// * `ThemeData`
/// * `SharedPreferences`

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This notifier class is responsible for managing the application's theme.
class ThemeNotifier extends ChangeNotifier {
  /// The dark theme configuration.
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

  /// The light theme configuration.
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

  /// The current theme data.
  ThemeData _themeData = ThemeData();

  /// Returns the current theme data.
  ThemeData getTheme() => _themeData;

  /// Initializes the theme notifier with the given theme preference.
  ThemeNotifier({required bool isDark}) {
    _themeData = darkTheme;
    if (!isDark) {
      _themeData = lightTheme;
      notifyListeners();
    }
  }

  /// Toggles the theme mode between light and dark.
  ///
  /// This method updates the theme preference in the shared preferences and
  /// notifies the listeners to rebuild the UI with the new theme.
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
