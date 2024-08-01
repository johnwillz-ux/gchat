import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_chat/providers/chat_provider.dart';
import 'package:g_chat/providers/user_provider.dart';
import 'package:g_chat/repositories/auth_repository.dart';
import 'package:g_chat/repositories/chat_repository.dart';
import 'package:g_chat/router.dart';
import 'package:g_chat/services/auth_verification.dart';
import 'package:g_chat/services/firebase_services.dart';
import 'package:g_chat/providers/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The main entry point of the application.
///
/// This function initializes the Flutter app, sets up the providers, and runs the app.
///
void main() async {
  /// Ensure that the Flutter app is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase.
  await initializeFirebase();

  /// Set the preferred orientations to portrait up and down.
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// Get the shared preferences instance.
  final prefs = await SharedPreferences.getInstance();

  /// Get the isDarkMode value from shared preferences.
  final bool isDark = prefs.getBool('isDarkMode') ?? false;

  /// Run the app with the providers.
  runApp(MultiProvider(
    providers: [
      /// ThemeNotifier is independent of other providers.
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(isDark: isDark),
      ),

      /// AuthRepository provider
      ChangeNotifierProvider(
        create: (_) => AuthRepository(
          auth: FirebaseAuth.instance,
          fireStore: FirebaseFirestore.instance,
        ),
      ),

      /// ChatRepository provider
      ChangeNotifierProvider(
        create: (_) => ChatRepository(
          auth: FirebaseAuth.instance,
          fireStore: FirebaseFirestore.instance,
        ),
      ),

      /// UserProvider provider
      ChangeNotifierProxyProvider<ChatRepository, UserProvider>(
        create: (context) => UserProvider(
          chatRepository: context.read<ChatRepository>(),
          auth: FirebaseAuth.instance,
        ),
        update: (context, chatRepo, userProvider) => userProvider!..loadUsers(),
      ),

      /// ChatProvider provider
      ChangeNotifierProvider(
        create: (context) => ChatProvider(
          chatRepository: context.read<ChatRepository>(),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

/// The main app widget.
///
/// This widget uses the providers to get the theme data and build the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get the theme data from the provider.
    final themeData = Provider.of<ThemeNotifier>(context, listen: true);

    /// Build the app with the theme data.
    return MaterialApp(
      theme: themeData.getTheme(),
      debugShowCheckedModeBanner: false,
     home: const AuthVerification(),
    );
  }
}
