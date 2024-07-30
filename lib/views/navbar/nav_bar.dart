import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/theme_notifier.dart';
import 'package:g_chat/views/chat/chat_view.dart';
import 'package:g_chat/views/profile/profile_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  final destinationViews = [const ChatView(), const ProfileView()];

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeNotifier>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData.getTheme(),
      home: Scaffold(
        body: destinationViews[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: Colors.white,
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          indicatorColor: Colors.white,
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
