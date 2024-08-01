import 'package:flutter/material.dart';
import 'package:g_chat/common/utils.dart';
import 'package:g_chat/repositories/auth_repository.dart';
import 'package:g_chat/providers/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = "/profile-view";
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeNotifier>(context);
    final authRepository = Provider.of<AuthRepository>(context);

    return FutureBuilder(
      future: _loadUserData(),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading user data'));
        }

        final data = snapshot.data;
        final fullName = data?['userFullName'] ?? 'No name';
        final email = data?['userEmail'] ?? 'No email';

        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Profile",
              style: AppTextStyles.headingMedium,
            ),
            backgroundColor: themeData.getTheme() == themeData.lightTheme
                ? Colors.white
                : Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: themeData.getTheme() == themeData.lightTheme
                        ? Colors.white
                        : Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        child: Text(
                          getInitials(fullName),
                          style: AppTextStyles.h3,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: AppTextStyles.h3,
                          ),
                          Text(
                            email,
                            style: AppTextStyles.bodySmallFont,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: themeData.getTheme() == themeData.lightTheme
                        ? Colors.white
                        : Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark Mode",
                        style: AppTextStyles.h3,
                      ),
                      Switch(
                        value: themeData.getTheme() == themeData.darkTheme,
                        onChanged: (value) {
                          themeData.toggleThemeMode();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    authRepository.signOutUser(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.red),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                  child: const Text(kLogOutButton),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, String>> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'userFullName': prefs.getString('userFullName') ?? 'No name',
      'userEmail': prefs.getString('userEmail') ?? 'No email',
    };
  }
}
