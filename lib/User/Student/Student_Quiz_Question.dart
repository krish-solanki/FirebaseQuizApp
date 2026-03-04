import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentQuizQuestion extends StatefulWidget {
  const StudentQuizQuestion({super.key});

  @override
  State<StudentQuizQuestion> createState() => _StudentQuizQuestionState();
}

class _StudentQuizQuestionState extends State<StudentQuizQuestion> {
  int selectedOptionIndex = -1;
  int index = 3;
  int lastIndex = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F6FA),
        elevation: 0,
        centerTitle: true,
        title: Image.asset('images/logo.png', height: 32.h),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 15.h),

                /// CATEGORY TITLE
                Text("Flutter Basics", style: AppTextStyles.sectionTitle),

                SizedBox(height: 14.h),

                /// TIMER DISPLAY
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "07:49",
                    style: AppTextStyles.timerText.copyWith(
                      color: Colors.redAccent,
                    ),
                  ),
                ),

                SizedBox(height: 22.h),

                /// PROGRESS BAR
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: LinearProgressIndicator(
                    value: index / lastIndex,
                    minHeight: 7.h,
                    backgroundColor: const Color(0xFFE3E6F0),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryBlue,
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  "Question $index / $lastIndex",
                  style: AppTextStyles.progressText,
                ),

                SizedBox(height: 22.h),

                /// QUESTION CARD
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Question $index:",
                        style: AppTextStyles.sectionTitle,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "What is Flutter primarily used for?",
                        style: AppTextStyles.questionText,
                      ),
                      SizedBox(height: 24.h),
                      _buildOption(0, "A UI toolkit"),
                      _buildOption(1, "A web browser"),
                      _buildOption(2, "A search engine"),
                      _buildOption(3, "A programming language"),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                /// NAVIGATION BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          if (index > 1) setState(() => index--);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: BorderSide(color: AppColors.primaryBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          "Previous",
                          style: AppTextStyles.buttonSecondary,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryBlue,
                              AppColors.primaryBlue.withOpacity(0.75),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (index < lastIndex) setState(() => index++);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Text(
                            "Next",
                            style: AppTextStyles.buttonPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h), // Extra space at bottom for scrolling
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption(int optionIndex, String text) {
    final isSelected = selectedOptionIndex == optionIndex;

    return GestureDetector(
      onTap: () => setState(() => selectedOptionIndex = optionIndex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primaryBlue,
                    AppColors.primaryBlue.withOpacity(0.7),
                  ],
                )
              : null,
          color: isSelected ? null : const Color(0xFFF7F8FC),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : const Color(0xFFE0E3ED),
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: isSelected
                    ? AppTextStyles.optionSelected
                    : AppTextStyles.optionText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
