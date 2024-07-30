import 'package:flutter/material.dart';
import 'package:g_chat/views/auth/onboard_view.dart';
import 'package:g_chat/views/auth/sign_in_view.dart';
import 'package:g_chat/views/auth/sign_up_view.dart';
import 'package:g_chat/views/navbar/nav_bar.dart';

/// Generates a route based on the provided [RouteSettings].
///
/// This function is used to navigate between different views in the app.
///
/// [settings] The [RouteSettings] object that contains the route name.
///
/// Returns a [Route] object that corresponds to the route name.
///
/// Example:
///
/// ```dart
/// Navigator.pushNamed(context, OnboardView.routeName);
/// ```
///
/// This will navigate to the [OnboardView] using the route name defined in [OnboardView.routeName].

Route<dynamic> generateRoute(RouteSettings settings) {
  /// Switches on the route name to determine which view to navigate to.
  switch (settings.name) {
    case OnboardView.routeName:

      /// Returns a [MaterialPageRoute] that builds the [OnboardView].
      return MaterialPageRoute(builder: (context) => const OnboardView());

    case SignUpView.routeName:

      /// Returns a [MaterialPageRoute] that builds the [SignUpView].
      return MaterialPageRoute(builder: (context) => const SignUpView());

    case SignInView.routeName:

      /// Returns a [MaterialPageRoute] that builds the [SignInView].
      return MaterialPageRoute(builder: (context) => const SignInView());

    case NavBar.routeName:

      /// Returns a [MaterialPageRoute] that builds the [NavBar].
      return MaterialPageRoute(builder: (context) => const NavBar());

    default:

      /// Returns a [MaterialPageRoute] that builds a default "Page Doesn't Exist" view.
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Scaffold(
                  body: Center(
                    child: Text("Page Doesn't Exist"),
                  ),
                ),
              ));
  }
}
