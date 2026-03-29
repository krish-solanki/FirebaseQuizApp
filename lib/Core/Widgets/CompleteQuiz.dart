import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CompletedQuiz extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> quizzes;
  final String studentId;

  const CompletedQuiz({
    super.key,
    required this.quizzes,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    /// ✅ FILTER COMPLETED QUIZZES (END DATE PASSED)
    final completedQuizzes = quizzes.where((q) {
      final data = q.data();
      final end = (data['endDate'] as Timestamp).toDate();
      return now.isAfter(end);
    }).toList();

    /// EMPTY STATE
    if (completedQuizzes.isEmpty) {
      return const Center(child: Text("No Completed Quiz"));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: completedQuizzes.length,
      itemBuilder: (context, index) {
        final quizData = completedQuizzes[index].data();

        final startDate =
            (quizData['startDate'] as Timestamp).toDate();
        final endDate =
            (quizData['endDate'] as Timestamp).toDate();

        final formattedDate =
            "${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}";

        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: AppColors.borderColor,
                width: 1.w,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TITLE + STATUS
                Row(
                  children: [
                    Text(
                      quizData['title'] ?? '',
                      style: AppTextStyles.sectionTitle,
                    ),
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

                /// DATE RANGE
                Text(
                  formattedDate,
                  style: AppTextStyles.bodySecondary,
                ),

                SizedBox(height: 10.h),

                /// TOTAL QUESTIONS
                Row(
                  children: [
                    Icon(
                      Icons.help_outline,
                      size: 18,
                      color: AppColors.primaryBlue,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "${quizData['totalQuestions'] ?? 0} Questions",
                      style: AppTextStyles.bodyPrimary.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View Details',
                        style: AppTextStyles.buttonSecondary,
                      ),
                    ),
                  ],
                ),

                /// STUDENT COUNT
                Row(
                  children: [
                    Icon(
                      Icons.group,
                      size: 16,
                      color: AppColors.primaryBlue,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      "${quizData['totalAttendees'] ?? 0} Students",
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
}