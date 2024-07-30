import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';
import 'package:g_chat/constants/app_text_styles.dart';
import 'package:g_chat/repositories/auth_repository.dart';
import 'package:provider/provider.dart';

class GlobalButton extends StatelessWidget {
  final String btnName;
  final VoidCallback onTap;
  const GlobalButton({
    super.key,
    required this.btnName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRepository>(builder: (context, authRepo, child) {
      return Column(
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.black),
                  backgroundColor: WidgetStateProperty.all(AppColors.kPrimary),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ))),
              child: authRepo.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 0.9,
                    )
                  : Text(
                      btnName,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyNormalFont
                          .copyWith(color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
    });
  }
}
