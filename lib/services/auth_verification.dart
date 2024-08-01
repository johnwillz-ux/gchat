import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:g_chat/views/auth/onboard_view.dart';
import 'package:g_chat/views/navbar/nav_bar.dart';

/// This Widget handles authentication verification using Firebase Authentication.
///
/// It uses a [StreamBuilder] to listen to changes in the authentication state
/// and returns either a [NavBar] if the user is authenticated or an [OnboardView]
/// if the user is not authenticated.

class AuthVerification extends StatelessWidget {
  /// Creates an instance of [AuthVerification].
  const AuthVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        /// Listens to changes in the authentication state.
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          /// If the connection is waiting, displays a [CircularProgressIndicator].
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// If the user is authenticated, returns a [NavBar].
          if (snapshot.hasData) {
            return const NavBar();
          }

          /// If the user is not authenticated, returns an [OnboardView].
          return const OnboardView();
        },
      ),
    );
  }
}
