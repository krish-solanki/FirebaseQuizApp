import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LockedQuiz extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> quizzes;

  const LockedQuiz({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final lockedQuizzes = quizzes.where((q) {
      final data = q.data();
      final start = (data['startDate'] as Timestamp).toDate();
      return now.isBefore(start);
    }).toList();

    if (lockedQuizzes.isEmpty) {
      return const Center(child: Text("No Locked Quiz"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: lockedQuizzes.length,
      itemBuilder: (context, index) {
        final data = lockedQuizzes[index].data();

        final startDate = (data['startDate'] as Timestamp).toDate();
        final endDate = (data['endDate'] as Timestamp).toDate();

        final formattedDate =
            "${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}";

        final duration = startDate.difference(now);

        final days = duration.inDays;
        final hours = duration.inHours % 24;
        final minutes = duration.inMinutes % 60;

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
                /// TITLE + LOCK STATUS
                Row(
                  children: [
                    Text(
                      data['title'] ?? '',
                      style: AppTextStyles.sectionTitle,
                    ),
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
                          SizedBox(width: 4.w),
                          Text(
                            'Starts in ${days}d ${hours}h ${minutes}m',
                            style: AppTextStyles.statusWarning,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                /// DATE RANGE
                Text(formattedDate, style: AppTextStyles.bodySecondary),

                SizedBox(height: 10.h),

                /// ACCESS CODE (DISABLED)
                accessCodeRow(),

                SizedBox(height: 8.h),

                /// STUDENTS COUNT
                Row(
                  children: [
                    Icon(Icons.group, size: 16, color: AppColors.primaryBlue),
                    SizedBox(width: 6.w),
                    Text(
                      "${data['totalAttendees'] ?? 0} Students",
                      style: AppTextStyles.bodySecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget accessCodeRow({bool isEnabled = false}) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              enabled: false,
              style: AppTextStyles.inputText,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Enter Access Code',
                hintStyle: AppTextStyles.inputHint,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.lockedBgColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.lock, size: 16, color: AppColors.textDisabled),
                SizedBox(width: 4.w),
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
        ],
      ),
    );
  }
}
