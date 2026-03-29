import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Functionality/StudentHomeService/StudentHomeService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class StudentResult extends StatefulWidget {
  const StudentResult({super.key});

  @override
  State<StudentResult> createState() => _StudentResultState();
}

class _StudentResultState extends State<StudentResult> {
  @override
  Widget build(BuildContext context) {
    final studentId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      backgroundColor: AppColors.appBackground,

      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        title: Text(
          "My Results",
          style: AppTextStyles.sectionTitle.copyWith(fontSize: 18.sp),
        ),
      ),

      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: StudentHomeService.getAllQuiz(),
          builder: (context, quizSnapshot) {
            if (quizSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!quizSnapshot.hasData || quizSnapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Quiz Found"));
            }

            final quizzes = quizSnapshot.data!.docs;

            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(studentId)
                  .collection('quizAttempts')
                  .snapshots(),
              builder: (context, attemptSnapshot) {
                if (attemptSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!attemptSnapshot.hasData ||
                    attemptSnapshot.data!.docs.isEmpty) {
                  return _emptyState();
                }

                final attempts = attemptSnapshot.data!.docs;

                final completedIds = attempts
                    .map((e) => e['moduleId'])
                    .toList();

                final completedQuizzes = quizzes
                    .where((quiz) => completedIds.contains(quiz.id))
                    .toList();

                if (completedQuizzes.isEmpty) {
                  return _emptyState();
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  itemCount: completedQuizzes.length,
                  itemBuilder: (context, index) {
                    final quizData = completedQuizzes[index].data();

                    final attempt = attempts.firstWhere(
                      (e) => e['moduleId'] == completedQuizzes[index].id,
                    );

                    return Container(
                      margin: EdgeInsets.only(bottom: 14.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔥 TITLE + STATUS
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  quizData['title'],
                                  style: AppTextStyles.sectionTitle.copyWith(
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.successLight,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  'Completed',
                                  style: AppTextStyles.resultStatusSuccess,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.h),

                          /// 📅 DATE
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: Colors.grey,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                DateFormat('dd MMM yyyy').format(
                                  (attempt['attemptDate'] as Timestamp)
                                      .toDate(),
                                ),
                                style: AppTextStyles.bodySecondary,
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          /// 🏆 SCORE
                          Row(
                            children: [
                              Icon(
                                Icons.emoji_events,
                                color: AppColors.scoreBlue,
                                size: 20,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "${attempt['marks'] ?? 0} / ${quizData['totalQuestions'] ?? 0}",
                                style: AppTextStyles.bodyPrimary.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                              const Spacer(),

                              /// BUTTON
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View',
                                    style: TextStyle(
                                      color: AppColors.primaryBlue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10.h),

                          /// 👥 STUDENTS
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
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  /// 🔥 EMPTY STATE
  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.quiz_outlined, size: 60, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "No Completed Quiz",
            style: AppTextStyles.sectionTitle.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
