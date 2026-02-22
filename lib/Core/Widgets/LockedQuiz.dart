import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LockedQuiz extends StatefulWidget {
  const LockedQuiz({super.key});

  @override
  State<LockedQuiz> createState() => _LockedQuizState();
}

class _LockedQuizState extends State<LockedQuiz> {
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.borderColor, width: 1.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Data Structures', style: AppTextStyles.sectionTitle),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.warningLight,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 16,
                            color: AppColors.warningYellow,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Start in 2d 4h 30m',
                            style: AppTextStyles.statusWarning,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                Text(
                  'Sep 10, 2025 - Sep 12, 2025',
                  style: AppTextStyles.bodySecondary,
                ),

                SizedBox(height: 10.h),

                /// ACCESS CODE ROW
                accessCodeRow(),

                SizedBox(height: 8.h),

                /// STUDENT COUNT
                Row(
                  children: [
                    Icon(Icons.group, size: 16, color: AppColors.primaryBlue),
                    SizedBox(width: 6.w),
                    Text('57 Students', style: AppTextStyles.bodySecondary),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget accessCodeRow({
    TextEditingController? controller,
    VoidCallback? onStartPressed,
    bool isEnabled = false,
  }) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          /// 🔹 ACCESS CODE INPUT (CENTERED TEXT)
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEnabled,
              style: AppTextStyles.inputText,
              textAlignVertical: TextAlignVertical.center, // ✅ FIX
              decoration: InputDecoration(
                hintText: 'Enter Access Code',
                hintStyle: AppTextStyles.inputHint,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                border: InputBorder.none,
              ),
            ),
          ),

          SizedBox(
            height: double.infinity,
            child: GestureDetector(
              onTap: isEnabled ? onStartPressed : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.lockedBgColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                  border: Border.all(color: AppColors.borderColor, width: 1.w),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Icon(Icons.lock, size: 16, color: AppColors.textDisabled),
                      Text(
                        'Locked',
                        style: AppTextStyles.buttonPrimary.copyWith(
                          fontSize: 13.sp,
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
