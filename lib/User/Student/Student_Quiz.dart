import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int selectedOptionIndex = 0;
  int index = 1;
  int last_index = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'images/logo.png',
          height: 35.h,
          fit: BoxFit.contain,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.scoreBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              Text('Flutter Basics', style: AppTextStyles.sectionTitle),
              SizedBox(height: 12.h),

              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 0.5,
                    ),
                  ),
                  child: Text("07:49", style: AppTextStyles.timerText),
                ),
              ),

              SizedBox(height: 20.h),

              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: 0.3,
                  minHeight: 8.h,
                  backgroundColor: AppColors.progressInactive,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryBlue,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Question ${index} / ${last_index}",
                style: AppTextStyles.progressText,
              ),

              SizedBox(height: 25.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${index}:',
                      style: AppTextStyles.sectionTitle,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'What is Flutter primarily used for?',
                      style: AppTextStyles.questionText,
                    ),
                    SizedBox(height: 20.h),

                    _buildOption(
                      index: 0,
                      text: "A UI toolkit",
                      isSelected: selectedOptionIndex == 0,
                    ),
                    _buildOption(
                      index: 1,
                      text: "A web browser",
                      isSelected: selectedOptionIndex == 1,
                    ),
                    _buildOption(
                      index: 2,
                      text: "A search engine",
                      isSelected: selectedOptionIndex == 2,
                    ),
                    _buildOption(
                      index: 3,
                      text: "A programming language",
                      isSelected: selectedOptionIndex == 3,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          if (index != 1) {
                            index--;
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primaryBlue),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "Previous",
                        style: AppTextStyles.buttonSecondary,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (index != last_index) {
                            index++;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text("Next", style: AppTextStyles.buttonPrimary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required String text,
    bool isSelected = false,
  }) {
    return GestureDetector(
      onTap: () => setState(() => selectedOptionIndex = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.borderColor,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? Colors.white : AppColors.textDisabled,
              size: 24.r,
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
