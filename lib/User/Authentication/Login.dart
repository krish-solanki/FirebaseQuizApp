import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Core/Widgets/InputField.dart';
import 'package:firebase_quiz_app/Functionality/LoginService/login_function.dart';
import 'package:firebase_quiz_app/User/Admin/Admin_Home.dart';
import 'package:firebase_quiz_app/User/Authentication/Register.dart';
import 'package:firebase_quiz_app/User/Student/Student_Bottom_Nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool isObserve = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: 200.w,
                        child: Image.asset('images/logo.png'),
                      ),

                      SizedBox(height: 15.h),
                      Text('Welcome Back!', style: AppTextStyles.pageTitle),
                      SizedBox(height: 8.h),
                      Text(
                        'Login to continue',
                        style: AppTextStyles.bodySecondary,
                      ),

                      SizedBox(height: 25.h),

                      buildInputField(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: "Email",
                        controller: emailController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10.h),

                      buildInputField(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Password",
                        controller: passwordController,
                        obscureText: isObserve,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => isObserve = !isObserve);
                          },
                          child: Icon(
                            isObserve ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.h, right: 16.w),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.buttonSecondary,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            minimumSize: Size(double.infinity, 52.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Login',
                            style: AppTextStyles.buttonPrimary,
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                'OR',
                                style: AppTextStyles.bodySecondary,
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cardBackground,
                            minimumSize: Size(double.infinity, 52.h),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              side: BorderSide(color: AppColors.borderColor),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/google.png', height: 20.h),
                              SizedBox(width: 10.w),
                              Text(
                                'Sign in with Google',
                                style: AppTextStyles.bodyPrimary,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 10.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            minimumSize: Size(double.infinity, 52.h),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            'Sign in with Facebook',
                            style: AppTextStyles.buttonPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// 🔹 BOTTOM CENTER TEXT (FIXED ✅)
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: AppTextStyles.bodySecondary,
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    ),
                    child: Text(
                      'Register',
                      style: AppTextStyles.buttonSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(String email, String password) async {
    try {
      // 🔹 Firebase login + role fetch
      final role = await LoginService.login(email: email, password: password);

      if (!mounted) return;

      // 🔹 Role based navigation
      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminHome()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const StudentBottomNav()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
