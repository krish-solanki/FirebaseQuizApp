import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Functionality/StudentProfileService/StudentProfileFunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  String? name, email;
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text('Profile', style: AppTextStyles.pageTitle),
              ),

              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
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
                          Text("${name}", style: AppTextStyles.profileName),
                          SizedBox(height: 4.h),
                          Text('${email}', style: AppTextStyles.profileEmail),
                        ],
                      ),

                      const Spacer(),

                      /// EDIT BUTTON
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryBlue),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            'Edit',
                            style: AppTextStyles.buttonSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text('Settings', style: AppTextStyles.sectionTitle),
              ),

              SizedBox(height: 8.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      _buildSettingRow(
                        icon: Icons.dark_mode,
                        title: 'Dark Mode',
                        showSwitch: true,
                      ),
                      Divider(height: 1, color: AppColors.borderColor),
                      _buildSettingRow(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        showSwitch: true,
                      ),
                      Divider(height: 1, color: AppColors.borderColor),
                      _buildSettingRow(
                        icon: Icons.privacy_tip,
                        title: 'Privacy',
                        showSwitch: false,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.errorRed,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text('Logout', style: AppTextStyles.logoutText),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 SETTING ROW WIDGET
  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required bool showSwitch,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.warningYellow),
          SizedBox(width: 12.w),
          Text(title, style: AppTextStyles.bodyPrimary),
          const Spacer(),
          if (showSwitch)
            Switch(value: false, onChanged: (value) {})
          else
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.textDisabled,
            ),
        ],
      ),
    );
  }

  Future<void> loadUser() async {
    final userData = await StudentProfileFunction.getUserDetails();

    if (userData != null) {
      setState(() {
        name = userData["name"];
        email = userData["email"];
      });
    }
  }
}
