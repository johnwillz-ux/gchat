import 'package:flutter/material.dart';
import 'package:g_chat/common/auth_bottom_widget.dart';
import 'package:g_chat/common/global_button.dart';
import 'package:g_chat/common/global_text_form_field.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';
import 'package:g_chat/repositories/auth_repository.dart';
import 'package:g_chat/views/auth/sign_in_view.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  static const String routeName = "/sign-up";
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();


    final authRepo = context.read<AuthRepository>();
    final signUpFormKey = GlobalKey<FormState>();

    void registerUser() {
      if (signUpFormKey.currentState!.validate()) {
        authRepo.signUpUser(
          context: context,
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          fullName: fullNameController.text.trim(),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.kBg2Color,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: signUpFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign Up",
                    style: AppTextStyles.headingLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(kFillRegisterFields,
                      style: AppTextStyles.bodySmallFont.copyWith(
                          fontWeight: FontWeight.w500, color: Colors.black54)),
                  const SizedBox(
                    height: 20,
                  ),
                  GlobalTextFormField(
                    controller: fullNameController,
                    hintText: 'Full Name',
                    suffixIcon: const Icon(IconlyLight.profile),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Full Name';
                      } else if (value.length < 2) {
                        return 'Full Name should be at least 2 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GlobalTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
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
                      }),
                ],
              ),
              Column(
                children: [
                  GlobalButton(
                    btnName: kRegisterButton.toUpperCase(),
                    onTap: () => registerUser(),
                  ),
                  AuthBottomAccountWidget(
                    textOne: kAlreadyHaveAccount,
                    textTwo: kLoginButton,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInView()),
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
