/// A navigation bar widget that handles routing between different views.
///
/// The [NavBar] widget uses the [NavigationBar] widget from Flutter to create a
/// bottom navigation bar with two destinations: Chat and Profile. It uses the
/// [Provider] package to listen to theme changes and update the UI accordingly.
///
/// Example:
///
/// ```dart
/// void main() {
///   runApp(
///     MultiProvider(
///       providers: [
///         ChangeNotifierProvider(create: (_) => ThemeNotifier()),
///       ],
///       child: MyApp(),
///     ),
///   );
/// }
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return MaterialApp(
///       title: 'G Chat',
///       home: NavBar(),
///     );
///   }
/// }
/// ```
///
/// To use this widget, simply call it in your app's [MaterialApp] widget.

import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/providers/theme_notifier.dart';
import 'package:g_chat/views/chat/chat_view.dart';
import 'package:g_chat/views/profile/profile_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

/// A navigation bar widget that handles routing between different views.
class NavBar extends StatefulWidget {


  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  /// The currently selected index in the navigation bar.
  int selectedIndex = 0;

  /// A list of destination views for the navigation bar.
  final destinationViews = [const ChatView(), const ProfileView()];

  @override
  Widget build(BuildContext context) {
    /// Get the current theme data from the [ThemeNotifier].
    final themeData = Provider.of<ThemeNotifier>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData.getTheme(),
      home: Scaffold(
        body: destinationViews[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: themeData.getTheme() == themeData.lightTheme
              ? Colors.white
              : Colors.black,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          indicatorColor: themeData.getTheme() == themeData.lightTheme
              ? Colors.white
              : Colors.black,
          destinations: const [
            NavigationDestination(
              tooltip: "Chat",
              selectedIcon: Icon(
                IconlyBold.chat,
                color: AppColors.kAccentColor,
              ),
              icon: Icon(
                IconlyLight.chat,
                color: AppColors.kTextDarkColor,
              ),
              label: "Chat",
            ),
            NavigationDestination(
              tooltip: "Profile",
              selectedIcon: Icon(
                IconlyBold.profile,
                color: AppColors.kAccentColor,
              ),
              icon: Icon(
                IconlyLight.profile,
                color: AppColors.kTextDarkColor,
              ),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
