import 'package:flutter/material.dart';
import 'package:g_chat/common/auth_bottom_widget.dart';
import 'package:g_chat/common/global_button.dart';
import 'package:g_chat/common/global_text_form_field.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';
import 'package:g_chat/repositories/auth_repository.dart';
import 'package:g_chat/views/auth/sign_up_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  static const String routeName = "/sign-in";
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final authRepo = context.read<AuthRepository>();
    final signInFormKey = GlobalKey<FormState>();

    void signInUser() {
      if (signInFormKey.currentState!.validate()) {
        authRepo.signInUser(
          context: context,
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: signInFormKey,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email address';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GlobalTextFormField(
                      controller: passwordController,
                      hintText: 'Password',
                      isPassword: true,
                      suffixIcon: const Icon(IconlyLight.password),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Create your Password';
                        } else if (value.length < 8) {
                          return 'Password should be more than 8 character';
                        }
                        return null;
                      })
                ],
              ),
              Column(
                children: [
                  GlobalButton(
                    btnName: kLoginButton.toUpperCase(),
                    onTap: () {
                      signInUser();
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
      ),
    );
  }
}
