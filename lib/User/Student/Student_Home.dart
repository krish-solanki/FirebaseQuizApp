import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Core/Widgets/AvalaibleQuiz.dart';
import 'package:firebase_quiz_app/Core/Widgets/CompleteQuiz.dart';
import 'package:firebase_quiz_app/Core/Widgets/LockedQuiz.dart';
import 'package:firebase_quiz_app/Functionality/StudentHomeService/StudentHomeService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome>
    with TickerProviderStateMixin {
  late TabController tabController;

  String? studentName;
  final List<String> tabView = ['Available', 'Locked', 'Completed'];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabView.length, vsync: this);
    getStudentName();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            /// TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Student Dashboard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Hello, $studentName',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Ready to test your knowledge',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),

            const SizedBox(height: 16),

            /// TAB BAR (FIXED ✅ FULL WIDTH)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: tabController,
                  isScrollable: false,
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: AppColors.whiteColor,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: AppTextStyles.scoreLabel,
                  unselectedLabelStyle: AppTextStyles.inputLabel,
                  tabs: tabView.map((title) => Tab(text: title)).toList(),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// TAB VIEW
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: StudentHomeService.getAllQuiz(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No Quiz Found"));
                  }
                  print("Docs count: ${snapshot.data!.docs.length}");

                  for (var doc in snapshot.data!.docs) {
                    print("Inside data isL ${doc.data()}");
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final quizzes = snapshot.data!.docs;
                  return TabBarView(
                    controller: tabController,
                    children: [
                      AvalaibleQuiz(quizzes: quizzes),
                      LockedQuiz(),
                      CompletedQuiz(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  getStudentName() async {
    try {
      final name = await StudentHomeService.getStudentName();
      setState(() {
        studentName = name;
      });
    } catch (e) {
      setState(() {
        studentName = 'Student';
      });
    }
  }
}
