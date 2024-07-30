import 'package:flutter/material.dart';
import 'package:g_chat/constants/app_colors.dart';

class GlobalTextFormField extends StatelessWidget {
  const GlobalTextFormField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.enabled = true,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.validator,
    this.width,
    super.key,
  });
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool enabled;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;
  final double? width;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return TextFormField(
      cursorColor: AppColors.kPrimary,
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      enabled: enabled,
      style: const TextStyle(
        fontFamily: 'Satoshi',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.6,
      ).copyWith(
        color: AppColors.kTextDarkColor,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(maxHeight: 40),
        enabled: enabled,
        alignLabelWithHint: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        constraints: BoxConstraints(
          maxWidth: width ?? w,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kTextDarkColor,
            width: 1,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kTextDarkColor,
            width: 1,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kPrimary,
            width: 2,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.kPrimary,
            width: 2,
          ),
        ),
        hintText: hintText,
        errorStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ).copyWith(
          color: Colors.red,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Satoshi',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.6,
        ).copyWith(
          color: AppColors.kTextDarkColor,
        ),
        errorMaxLines: 1,
        hintMaxLines: 1,
      ),
    );
  }
}
