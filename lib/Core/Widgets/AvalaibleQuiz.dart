import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AvalaibleQuiz extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> quizzes;

  const AvalaibleQuiz({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final available = quizzes.where((q) {
      final data = q.data();

      final start = (data['startDate'] as Timestamp).toDate();
      final end = (data['endDate'] as Timestamp).toDate();
      print("Quiz: ${data['title']}");
      print("NOW   : $now");
      print("START : $start");
      print("END   : $end");
      print("AVAILABLE = ${now.isAfter(start) && now.isBefore(end)}");
      print("----------------");
      print("Quiz is:  ${now.isAfter(start) && now.isBefore(end)}");
      return now.isAfter(start) && now.isBefore(end);
    }).toList();

    if (available.isEmpty) {
      return const Center(child: Text("No Available Quiz"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: available.length,
      itemBuilder: (context, index) {
        final data = available[index].data();

        final startDate = (data['startDate'] as Timestamp).toDate();
        final endDate = (data['endDate'] as Timestamp).toDate();

        final formattedStart = DateFormat(
          'dd MMM yyyy, hh:mm a',
        ).format(startDate);
        final formattedEnd = DateFormat('dd MMM yyyy, hh:mm a').format(endDate);

        final TextEditingController accessController = TextEditingController();

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
                    Text(
                      data['title'] ?? '',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successGreen,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        'Available',
                        style: AppTextStyles.statusActive,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6.h),

                Text(
                  '$formattedStart - $formattedEnd',
                  style: AppTextStyles.bodySecondary,
                ),

                SizedBox(height: 10.h),

                accessCodeRow(
                  controller: accessController,
                  onStartPressed: () {
                    final enteredCode = accessController.text.trim();

                    if (enteredCode == data['accessCode']) {
                      print("Access Granted for ${data['title']}");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid Access Code")),
                      );
                    }
                  },
                ),

                SizedBox(height: 8.h),

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

  Widget accessCodeRow({
    required TextEditingController controller,
    required VoidCallback onStartPressed,
    bool isEnabled = true,
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
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEnabled,
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
          SizedBox(
            height: double.infinity,
            child: GestureDetector(
              onTap: isEnabled ? onStartPressed : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Start Quiz',
                    style: AppTextStyles.buttonPrimary.copyWith(
                      fontSize: 13.sp,
                    ),
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
