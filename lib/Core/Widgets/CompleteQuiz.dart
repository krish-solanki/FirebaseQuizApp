import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CompletedQuiz extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> quizzes;
  final String studentId;
  CompletedQuiz({super.key, required this.quizzes, required this.studentId});

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(studentId)
          .collection('quizAttempts')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No Completed Quiz"));
        }

        final attempts = snapshot.data!.docs;
        final completedIds = attempts.map((e) => e['moduleId']).toList();
        final completedQuizzes = quizzes
            .where((quiz) => completedIds.contains(quiz.id))
            .toList();

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          itemCount: completedQuizzes.length,
          itemBuilder: (context, index) {
            final quizData = completedQuizzes[index].data();
            final attempt = attempts.firstWhere(
              (e) => e['moduleId'] == completedQuizzes[index].id,
            );
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
                        Text(
                          quizData['title'],
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

                    /// DATE
                    Text(
                      DateFormat(
                        'dd MMM yyyy',
                      ).format((attempt['attemptDate'] as Timestamp).toDate()),
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
                          "${attempt['marks'] ?? 0} / ${quizData['totalQuestions'] ?? 0}",
                          style: AppTextStyles.bodyPrimary.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'View Result',
                            style: AppTextStyles.buttonSecondary,
                          ),
                        ),
                      ],
                    ),

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
      },
    );
  }
}
