import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:g_chat/common/auth_bottom_widget.dart';
import 'package:g_chat/common/global_button.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';
import 'package:g_chat/providers/theme_notifier.dart';
import 'package:g_chat/views/auth/sign_in_view.dart';
import 'package:g_chat/views/auth/sign_up_view.dart';
import 'package:provider/provider.dart';

class OnboardView extends StatelessWidget {

  const OnboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      backgroundColor: themeData.getTheme() == themeData.darkTheme
          ? Colors.black12
          : AppColors.kBgColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              Column(
                children: [
                  SvgPicture.asset(
                    kGChatLogoPath,
                    width: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(style: AppTextStyles.headingLarge, "Hey!"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    kWelcomeMessage,
                    style: AppTextStyles.bodySmallFont.copyWith(
                      fontWeight: FontWeight.w500,
                      color: themeData.getTheme() == themeData.lightTheme
                          ? Colors.black45
                          : Colors.white54,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GlobalButton(
                    btnName: kGetStarted.toUpperCase(),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
                      );
                    },
                  ),
                  AuthBottomAccountWidget(
                    textOne: kAlreadyHaveAccount,
                    textTwo: kLoginButton,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInView()),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
