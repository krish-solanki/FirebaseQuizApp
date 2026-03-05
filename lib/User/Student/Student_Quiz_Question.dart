import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Functionality/StudentQuestionService/student_question)function.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentQuizQuestion extends StatefulWidget {
  final String moduleId;
  final String attemptId;

  const StudentQuizQuestion({
    super.key,
    required this.moduleId,
    required this.attemptId,
  });

  @override
  State<StudentQuizQuestion> createState() => _StudentQuizQuestionState();
}

class _StudentQuizQuestionState extends State<StudentQuizQuestion> {
  int selectedOptionIndex = -1;
  int index = 0;
  int? lastIndex;

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
        child: StreamBuilder(
          stream: StudentQuestionService.fetchQuestions(widget.moduleId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No Questions Found"));
            }

            final questions = snapshot.data!.docs;
            lastIndex = questions.length;

            final currentQuestion = questions[index];
            final questionId = currentQuestion.id;
            final options = currentQuestion['options'];

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Text(
                    "Question ${index + 1} / $lastIndex",
                    style: AppTextStyles.sectionTitle,
                  ),

                  SizedBox(height: 20.h),

                  LinearProgressIndicator(
                    value: (index + 1) / lastIndex!,
                    minHeight: 6.h,
                    color: AppColors.primaryBlue,
                  ),

                  SizedBox(height: 20.h),

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
                          currentQuestion['question'],
                          style: AppTextStyles.questionText,
                        ),

                        SizedBox(height: 24.h),

                        _buildOption(0, options['A'], questionId),
                        _buildOption(1, options['B'], questionId),
                        _buildOption(2, options['C'], questionId),
                        _buildOption(3, options['D'], questionId),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (index > 0) {
                              setState(() {
                                index--;
                                selectedOptionIndex = -1;
                              });
                            }
                          },
                          child: const Text("Previous"),
                        ),
                      ),

                      SizedBox(width: 15.w),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (index < lastIndex! - 1) {
                              setState(() {
                                index++;
                                selectedOptionIndex = -1;
                              });
                            }

                            if (index == lastIndex! - 1) {
                              StudentQuestionService.submitQuiz(
                                widget.attemptId , widget.moduleId
                              );
                            }
                          },
                          child: const Text("Next"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOption(int optionIndex, String text, String questionId) {
    final isSelected = selectedOptionIndex == optionIndex;

    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedOptionIndex = optionIndex;
        });

        final optionLetters = ['A', 'B', 'C', 'D'];
        final selectedLetter = optionLetters[optionIndex];

        await StudentQuestionService.saveAnswer(
          widget.attemptId,
          questionId,
          selectedLetter,
        );
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : const Color(0xFFF7F8FC),
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
