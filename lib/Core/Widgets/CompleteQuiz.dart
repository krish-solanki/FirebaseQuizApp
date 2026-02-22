import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CompletedQuiz extends StatefulWidget {
  const CompletedQuiz({super.key});

  @override
  State<CompletedQuiz> createState() => _CompletedQuizState();
}

class _CompletedQuizState extends State<CompletedQuiz> {
  @override
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
                /// TITLE + STATUS
                Row(
                  children: [
                    Text('Flutter Basics', style: AppTextStyles.sectionTitle),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        'Completed',
                        style: AppTextStyles.resultStatusSuccess,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                /// DATE
                Text(
                  'Apr 10, 2025 - Apr 12, 2025',
                  style: AppTextStyles.bodySecondary,
                ),

                Row(
                  children: [
                    Icon(
                      Icons.emoji_events_outlined,
                      size: 18,
                      color: AppColors.scoreBlue,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '8 / 10',
                      style: AppTextStyles.bodyPrimary.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'View Result',
                        style: AppTextStyles.buttonSecondary,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(Icons.group, size: 16, color: AppColors.primaryBlue),
                    SizedBox(width: 6.w),
                    Text('58 Students', style: AppTextStyles.bodySecondary),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
