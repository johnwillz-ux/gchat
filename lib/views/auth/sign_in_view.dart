import 'package:flutter/material.dart';
import 'package:g_chat/common/auth_bottom_widget.dart';
import 'package:g_chat/common/global_button.dart';
import 'package:g_chat/common/global_text_form_field.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';
import 'package:g_chat/views/auth/sign_up_view.dart';
import 'package:g_chat/views/navbar/nav_bar.dart';
import 'package:iconly/iconly.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: AppTextStyles.headingLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(kLoginWithExistingAccount,
                    style: AppTextStyles.bodySmallFont.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.black54)),
                const SizedBox(
                  height: 20,
                ),
                GlobalTextFormField(
                  controller: emailController,
                  hintText: 'Email ',
                  suffixIcon: const Icon(IconlyLight.message),
                ),
                const SizedBox(
                  height: 15,
                ),
                GlobalTextFormField(
                  controller: emailController,
                  hintText: 'Password',
                  suffixIcon: const Icon(IconlyLight.password),
                )
              ],
            ),
            Column(
              children: [
                GlobalButton(
                  btnName: kLoginButton.toUpperCase(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NavBar()),
                    );
                  },
                ),
                AuthBottomAccountWidget(
                  textOne: kAlreadyHaveAccount,
                  textTwo: kRegisterButton,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpView()),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
