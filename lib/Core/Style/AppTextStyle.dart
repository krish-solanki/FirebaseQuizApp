import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  AppTextStyles._(); // prevent instantiation

  // =========================
  // 🧭 APP BAR / PAGE TITLES
  // =========================
  static TextStyle pageTitle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle sectionTitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // =========================
  // 📝 BODY TEXT
  // =========================
  static TextStyle bodyPrimary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle bodySecondary = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle bodyDisabled = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textDisabled,
  );

  static TextStyle bodyEnable = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlue,
  );

  // =========================
  // 🔘 BUTTON TEXT
  // =========================
  static TextStyle buttonPrimary = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle buttonSecondary = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlue,
  );

  static TextStyle buttonDanger = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // =========================
  // 🧾 INPUTS & LABELS
  // =========================
  static TextStyle inputText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle inputHint = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    // color: AppColors.textDisabled,
    color: Colors.black,
  );

  static TextStyle inputLabel = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // =========================
  // 📊 STATUS / BADGES
  // =========================
  static TextStyle statusActive = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle statusWarning = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.warningYellow,
  );

  static TextStyle statusClosed = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.errorRed,
  );

  // =========================
  // ⏱ TIMER & PROGRESS
  // =========================
  static TextStyle timerText = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.timerRed,
  );

  static TextStyle progressText = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  // =========================
  // 🧠 QUIZ QUESTION
  // =========================
  static TextStyle questionText = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle optionText = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static TextStyle optionSelected = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  // =========================
  // 🏆 RESULT & SCORE
  // =========================
  static TextStyle scoreBig = TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.scoreBlue,
  );

  static TextStyle scoreLabel = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle resultStatusSuccess = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.successGreen,
  );

  static TextStyle resultStatusPending = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.warningYellow,
  );

  // =========================
  // 👤 PROFILE & SETTINGS
  // =========================
  static TextStyle profileName = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle profileEmail = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle logoutText = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
