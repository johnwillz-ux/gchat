import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/constants/constant.dart';

class AuthBottomAccountWidget extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final VoidCallback onTap;

  const AuthBottomAccountWidget({
    super.key,
    required this.textOne,
    required this.textTwo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Wrap(
        children: [
          Text(
            kAlreadyHaveAccount,
            style: AppTextStyles.bodySmallFont,
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              textTwo,
              style: AppTextStyles.bodySmallFont.copyWith(
                  color: AppColors.kPrimary, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
