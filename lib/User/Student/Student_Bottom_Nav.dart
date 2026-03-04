import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Core/Widgets/QuestionUI.dart';
import 'package:firebase_quiz_app/User/Authentication/Login.dart';
import 'package:firebase_quiz_app/User/Authentication/Register.dart';
import 'package:firebase_quiz_app/User/Student/Student_Home.dart';
import 'package:firebase_quiz_app/User/Student/Student_Profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentBottomNav extends StatefulWidget {
  const StudentBottomNav({super.key});

  @override
  State<StudentBottomNav> createState() => _StudentBottomNavState();
}

class _StudentBottomNavState extends State<StudentBottomNav> {
  int selectedIndex = 0;

  final List<Widget> screens = const [
    StudentHome(),
    Questions(),
    StudentProfile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.borderColor, width: 3.w),
          ),
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onItemTapped,
            backgroundColor: AppColors.whiteColor,
            elevation: 8,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryBlue,
            unselectedItemColor: AppColors.textDisabled,
            selectedLabelStyle: AppTextStyles.bodyEnable,
            unselectedLabelStyle: AppTextStyles.bodyDisabled,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today_rounded),
                label: 'Results',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
