import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/providers/user_provider.dart';
import 'package:g_chat/repositories/auth_repository.dart';
import 'package:g_chat/repositories/chat_repository.dart';
import 'package:g_chat/router.dart';
import 'package:g_chat/services/auth_verification.dart';
import 'package:g_chat/services/firebase_services.dart';
import 'package:g_chat/providers/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  final bool isDark =
      (await SharedPreferences.getInstance()).getBool('isDarkMode') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(isDark: isDark),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthRepository(
            auth: FirebaseAuth.instance,
            fireStore: FirebaseFirestore.instance,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatRepository(
            fireStore: FirebaseFirestore.instance,
          ),
        ),
        ChangeNotifierProxyProvider<ChatRepository, UserProvider>(
          create: (context) => UserProvider(
            chatRepository: context.read<ChatRepository>(),
            auth: FirebaseAuth.instance,
          ),
          update: (context, chatRepo, userProvider) =>
          userProvider!..loadUsers(),
        ),
      ],
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
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthVerification(),
    );
  }
}
