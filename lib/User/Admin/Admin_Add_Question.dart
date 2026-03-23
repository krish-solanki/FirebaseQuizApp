import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddModule extends StatefulWidget {
  const AddModule({super.key});

  @override
  State<AddModule> createState() => _AddModuleState();
}

class _AddModuleState extends State<AddModule> {
  final List<QuestionModel> questions = [];

  //Module controllers
  final TextEditingController moduleTitle = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController accessCode = TextEditingController(
    text: "ABC123",
  );

  DateTime? startDate;
  DateTime? endDate;

  bool autoGenerate = true;

  // Questions list

  @override
  void initState() {
    super.initState();
    _addQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Add Module", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuestion,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _section("Module Title"),

            _input("Module Title", moduleTitle),
            SizedBox(height: 12.h),

            _section("Description"),
            _input("Description", description),

            SizedBox(height: 20.h),

            _section("Schedule"),

            _dateTile("Start Date", startDate, () => _pickDate(true)),
            SizedBox(height: 10.h),
            _dateTile("End Date", endDate, () => _pickDate(false)),

            SizedBox(height: 20.h),

            _section("Security"),

            Container(
              padding: EdgeInsets.all(12.r),
              decoration: _box(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: accessCode,
                      enabled: !autoGenerate,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: "Access Code",
                      ),
                    ),
                  ),
                  Switch(
                    value: autoGenerate,
                    onChanged: (v) {
                      setState(() {
                        autoGenerate = v;
                        if (v) {
                          accessCode.text = "ABC123";
                        }
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            _section("Questions"),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return _questionCard(index);
              },
            ),

            SizedBox(height: 20.h),

            ElevatedButton(
              onPressed: () {
                _saveModule();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 52.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Save Module"),
            ),
          ],
        ),
      ),
    );
  }

  // UI HELPERS

  Widget _section(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Text(
        title,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _input(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _dateTile(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: _box(),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            SizedBox(width: 12.w),
            Text(
              date == null ? label : "${date.day}/${date.month}/${date.year}",
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionCard(int index) {
    final q = questions[index];

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: _box(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${index + 1}",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),

          _input("Enter question", q.questionController),
          SizedBox(height: 12.h),

          _option("Option A", q.optionA),
          _option("Option B", q.optionB),
          _option("Option C", q.optionC),
          _option("Option D", q.optionD),

          SizedBox(height: 10.h),

          DropdownButtonFormField<String>(
            value: q.correctAnswer,
            items: const [
              DropdownMenuItem(value: 'A', child: Text("Correct: A")),
              DropdownMenuItem(value: 'B', child: Text("Correct: B")),
              DropdownMenuItem(value: 'C', child: Text("Correct: C")),
              DropdownMenuItem(value: 'D', child: Text("Correct: D")),
            ],
            onChanged: (v) => setState(() => q.correctAnswer = v!),
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  Widget _option(String hint, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          const Icon(Icons.radio_button_unchecked, size: 18),
          SizedBox(width: 8.w),
          Expanded(child: _input(hint, controller)),
        ],
      ),
    );
  }

  BoxDecoration _box() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Future<void> _pickDate(bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _addQuestion() {
    setState(() {
      questions.add(QuestionModel());
    });
  }

  Future<void> _saveModule() async {
    if (moduleTitle.text.isEmpty ||
        description.text.isEmpty ||
        startDate == null ||
        endDate == null ||
        questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and add at least one question"),
        ),
      );
      return;
    }

    try {
      final firestore = FirebaseFirestore.instance;

      final moduleRef = firestore.collection('modules').doc();

      await moduleRef.set({
        "title": moduleTitle.text.trim(),
        "description": description.text.trim(),
        "accessCode": accessCode.text.trim(),
        "startDate": Timestamp.fromDate(startDate!),
        "endDate": Timestamp.fromDate(endDate!),
        "createdBy": FirebaseAuth.instance.currentUser?.uid,
        "createdAt": FieldValue.serverTimestamp(),
        "isActive": false,
        "isPending": true,
        'totalQuestions': questions.length,
        'attempts': 0,
        'totalAttendees': 0,
      });

      for (int i = 0; i < questions.length; i++) {
        final q = questions[i];
        await moduleRef.collection('questions').add({
          'question': q.questionController.text,
          'options': {
            'A': q.optionA.text,
            'B': q.optionB.text,
            'C': q.optionC.text,
            'D': q.optionD.text,
          },
          'correctAnswer': q.correctAnswer,
          'order': i + 1,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Module saved successfully")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}

class QuestionModel {
  TextEditingController questionController = TextEditingController();
  TextEditingController optionA = TextEditingController();
  TextEditingController optionB = TextEditingController();
  TextEditingController optionC = TextEditingController();
  TextEditingController optionD = TextEditingController();

  String correctAnswer = 'A';
}