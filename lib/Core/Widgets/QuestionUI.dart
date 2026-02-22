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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Question 3:', style: AppTextStyles.sectionTitle),
                  SizedBox(height: 8.h),
                  Text(
                    'What is Flutter primarily used for?',
                    style: AppTextStyles.questionText,
                  ),
                  SizedBox(height: 20.h),
                  // Options List
                  _buildOption(index: 0, text: "A UI toolkit", isSelected: selectedOptionIndex == 0),
                  _buildOption(index: 1, text: "A web browser", isSelected: selectedOptionIndex == 1),
                  _buildOption(index: 2, text: "A search engine", isSelected: selectedOptionIndex == 2),
                  _buildOption(index: 3, text: "A programming language", isSelected: selectedOptionIndex == 3),
                ],
              ),
            ),
            
            const Spacer(),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryBlue),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text("Previous", style: AppTextStyles.buttonSecondary),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                    ),
                    child: Text("Next", style: AppTextStyles.buttonPrimary),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({required int index, required String text, bool isSelected = false}) {
    return GestureDetector(
      onTap: () => setState(() => selectedOptionIndex = index),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
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
              size: 22.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                text,
                style: isSelected ? AppTextStyles.optionSelected : AppTextStyles.optionText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}