import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


Widget buildInputField({
  required Widget prefixIcon,
  TextEditingController? controller,
  required String hintText,
  String? Function(String?)? validator,
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return Padding(
    padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
    child: TextFormField(
      style: AppTextStyles.inputText,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: AppColors.cardBackground,
        hintText: hintText,
        hintStyle: AppTextStyles.inputHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5.w),
          ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(fontSize: 12, height: 1.2),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        suffixIcon: suffixIcon,
      ),
    ),
  );
}