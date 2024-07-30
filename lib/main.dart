import 'package:flutter/material.dart';
import 'package:g_chat/theme_notifier.dart';
import 'package:g_chat/views/auth/onboard_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isDark =
      (await SharedPreferences.getInstance()).getBool('isDarkMode') ?? true;

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(isDark: isDark),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      // home: const NavBar(),
      // home: const SignInView(),
      home: const OnboardView(),
    );
  }
}
