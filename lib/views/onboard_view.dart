import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/constants/constant.dart';
import 'package:g_chat/theme_notifier.dart';
import 'package:provider/provider.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: themeData.getTheme() == themeData.darkTheme
          ? Colors.black12
          : AppColors.primaryColor,
      body: Column(
        children: [
          Column(
            children: [
              SvgPicture.asset(
                kGChatLogoPath,
                width: 25,
              ),
              Text(
                  style: Theme.of(context).primaryTextTheme.headlineMedium,
                  "Hey!"),
              Text("Welcome  to GChat"),

            ],
          ),
        ],
      ),
    );
  }
}
