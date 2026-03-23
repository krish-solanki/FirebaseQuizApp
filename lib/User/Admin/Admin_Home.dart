// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Functionality/AdminHomeService/AdminHomeFunction.dart';
import 'package:firebase_quiz_app/User/Admin/Admin_Add_Question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int totalModules = 0;
  int totalStudents = 0;
  @override
  void initState() {
    super.initState();
    _countTotalModules();
    _countTotalStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddModule()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),

            // 🔹 Logo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Image.asset('images/logo.png', height: 40.h),
            ),

            SizedBox(height: 20.h),

            // 🔹 Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                },
                child: Text('Admin Dashboard', style: AppTextStyles.pageTitle),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              child: Text('Hello, Admin 👋', style: AppTextStyles.bodyPrimary),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Here is an overview of the modules and statistics.',
                style: AppTextStyles.bodySecondary,
              ),
            ),

            SizedBox(height: 20.h),

            // 🔹 Stats cards
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 1.8,
                ),
                children: [
                  _buildStatCard(
                    title: "Total Students",
                    value: totalStudents.toString(),
                    icon: Icons.person,
                    isGradient: true,
                    textColor: Colors.white,
                  ),
                  _buildStatCard(
                    title: "Exams Completed",
                    value: totalModules.toString(),
                    icon: Icons.assignment_turned_in,
                    isGradient: false,
                    textColor: AppColors.textPrimary,
                    iconColor: AppColors.successGreen,
                  ),
                ],
              ),
            ),

            SizedBox(height: 28.h),

            // 🔹 Modules overview
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Modules Overview',
                style: AppTextStyles.sectionTitle,
              ),
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('modules')
                    .where(
                      'createdBy',
                      isEqualTo: FirebaseAuth.instance.currentUser?.uid,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No quizzes created yet"));
                  }

                  final modules = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: modules.length,
                    itemBuilder: (context, index) {
                      final data = modules[index];
                      final startDate = (data['startDate'] as Timestamp)
                          .toDate();
                      final endDate = (data['endDate'] as Timestamp).toDate();
                      return _quizCard(
                        context: context,
                        title: data['title'],
                        description: data['description'],
                        startdate: startDate,
                        enddate: endDate,
                        students: data['totalAttendees'].toString(),
                        isActive: data['isActive'],
                        isPending: data['isPending'],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 STAT CARD
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required bool isGradient,
    required Color textColor,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isGradient ? null : AppColors.cardBackground,
        gradient: isGradient
            ? LinearGradient(
                colors: [AppColors.primaryBlue, const Color(0xFF60A5FA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isGradient
                    ? Colors.white.withOpacity(0.2)
                    : iconColor!.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isGradient ? Colors.white : iconColor,
                size: 22.r,
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isGradient
                        ? Colors.white.withOpacity(0.8)
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quizCard({
    required BuildContext context,
    required String title,
    required String description,
    required DateTime startdate,
    required DateTime enddate,
    required String students,
    required bool isActive,
    required bool isPending,
  }) {
    Color statusColor;

    if (isPending) {
      statusColor = AppColors.warningYellow;
    } else {
      if (isActive) {
        statusColor = AppColors.successGreen;
      } else {
        statusColor = AppColors.errorRed;
      }
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 12.r, right: 12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor, width: 1.w),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          margin: EdgeInsets.only(left: 4.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.sectionTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      isPending
                          ? "Pending"
                          : isActive
                          ? "Active"
                          : "Completed",
                      style: AppTextStyles.statusActive,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10.h),
              Text(
                description,
                style: AppTextStyles.bodyPrimary,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),

              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  Text(
                    "${startdate.day}/${startdate.month}/${startdate.year} - "
                    "${enddate.day}/${enddate.month}/${enddate.year}",
                    style: AppTextStyles.bodySecondary,
                  ),
                ],
              ),
              SizedBox(height: 4.h),

              Row(
                children: [
                  Icon(Icons.group, size: 16, color: AppColors.primaryBlue),
                  SizedBox(width: 6.w),
                  Text(students, style: AppTextStyles.bodySecondary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _countTotalModules() async {
    try {
      int count = await AdminHomefService.totalExams();

      setState(() {
        totalModules = count;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching total modules")));
    }
  }

  void _countTotalStudents() async {
    try {
      int count = await AdminHomefService.totalStudents();

      setState(() {
        totalStudents = count;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching total students")));
    }
  }
}
