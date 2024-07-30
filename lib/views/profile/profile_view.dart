import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';
import 'package:g_chat/theme_notifier.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyles.headingMedium,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emm Obi",
                        style: AppTextStyles.h3,
                      ),
                      Text(
                        "emm.obi@dm.com",
                        style: AppTextStyles.bodySmallFont,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                ),
                child: const Text(kLogOutButton)),
          ],
        ),
      ),
    );
  }
}
