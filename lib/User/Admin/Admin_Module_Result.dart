import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Functionality/AdminResultService/Admin_Module_Result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminModuleResult extends StatefulWidget {
  String moduleId;
  AdminModuleResult({super.key, required this.moduleId});

  @override
  State<AdminModuleResult> createState() => _AdminModuleResultState();
}

class _AdminModuleResultState extends State<AdminModuleResult> {
  int? totalMarks;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTotalMarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        title: Text(
          'Flutter Basics',
          style: AppTextStyles.sectionTitle.copyWith(fontSize: 18.sp),
        ),
        leading: Icon(Icons.arrow_back, color: AppColors.primaryBlue),
      ),
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                  Container(
                    padding: EdgeInsets.all(14.w),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.primaryBlue.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                          size: 20.sp,
                        ),

                        SizedBox(width: 10.w),

                        Container(
                          margin: EdgeInsets.only(top: 4.h, right: 4.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Apr 10, 2025 - 9:00 AM",
                                style: AppTextStyles.statusActive.copyWith(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "Apr 12, 2025 - 9:00 PM",
                                style: AppTextStyles.statusActive.copyWith(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        /// OPTIONAL ARROW ICON
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white.withOpacity(0.7),
                          size: 16,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  /// 🔽 BOTTOM ROW
                  Container(
                    padding: EdgeInsets.only(
                      left: 14.w,
                      right: 14.w,
                      bottom: 10.w,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock, size: 16, color: Colors.grey),
                        SizedBox(width: 6.w),
                        Text("ABC123", style: AppTextStyles.bodyPrimary),

                        const Spacer(),

                        /// TOGGLE + TEXT
                        Row(
                          children: [
                            Switch(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Colors.green,
                            ),
                            Text(
                              "Published",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: actionButton(
                      text: 'Edit',
                      color: AppColors.primaryBlue,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: actionButton(
                      text: 'Delete',
                      color: AppColors.timerRed,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.darkBackground,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: actionButton(
                        text: 'Publish Result',
                        color: AppColors.whiteColor,
                        textColor: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 14.sp, bottom: 8.sp, top: 5.sp),
              child: Text('Student Marks', style: AppTextStyles.sectionTitle),
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: AdminModuleResultService.getQuizResults(widget.moduleId),

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final results = snapshot.data!.docs;

                if (results.isEmpty) {
                  return const Center(child: Text("No Attempts Yet"));
                }
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final data = results[index].data();
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30.r),
                                child: Image.asset(
                                  'images/profile.jpg',
                                  height: 56.h,
                                  width: 56.w,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(width: 12.w),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${data['studentName'] ?? 'Student'}",
                                    style: AppTextStyles.profileName,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text('', style: AppTextStyles.profileEmail),
                                ],
                              ),

                              const Spacer(),
                              Text('${data['marks']} / ${totalMarks}'),
                              Icon(Icons.arrow_forward_ios_sharp),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton({
    required String text,
    required Color color,
    Color? textColor,
  }) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void getTotalMarks() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('modules')
          .doc(widget.moduleId)
          .get();

      final data = doc.data();

      setState(() {
        totalMarks = data?['totalQuestions'] ?? 0;
      });
    } catch (e) {
      print(e);
    }
  }
}
