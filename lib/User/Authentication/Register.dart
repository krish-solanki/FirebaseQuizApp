import 'package:firebase_quiz_app/Core/Style/AppColors.dart';
import 'package:firebase_quiz_app/Core/Style/AppTextStyle.dart';
import 'package:firebase_quiz_app/Core/Widgets/InputField.dart';
import 'package:firebase_quiz_app/Functionality/RegistrationFunction/registration.dart';
import 'package:firebase_quiz_app/User/Student/Student_Bottom_Nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisible = true;
  bool isLoading = false;

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await RegisterService.registerUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Registration successful")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StudentBottomNav()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100.h,
                        width: 200.w,
                        child: Image.asset('images/logo.png'),
                      ),

                      SizedBox(height: 15.h),
                      Text('Sign Up', style: AppTextStyles.pageTitle),
                      SizedBox(height: 8.h),
                      Text(
                        'Create Your Account',
                        style: AppTextStyles.bodySecondary,
                      ),
                      SizedBox(height: 25.h),

                      buildInputField(
                        prefixIcon: const Icon(Icons.person),
                        hintText: 'Name',
                        controller: nameController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter your name";
                          }
                          if (value.length < 3) {
                            return "Name must be at least 3 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      buildInputField(
                        prefixIcon: const Icon(Icons.email_outlined),
                        hintText: 'Email',
                        controller: emailController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Enter email";
                          }
                          if (!value.contains("@")) {
                            return "Enter valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),

                      buildInputField(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: isVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() => isVisible = !isVisible);
                          },
                          child: Icon(
                            isVisible ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.r),
                        child: ElevatedButton(
                          onPressed: isLoading ? null : register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            minimumSize: Size(double.infinity, 52.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Sign Up',
                                  style: AppTextStyles.buttonPrimary,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentBottomNav(),
                        ),
                      ),
                      child: Text(
                        'Already have an account?',
                        style: AppTextStyles.buttonSecondary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text('Login', style: AppTextStyles.buttonPrimary),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
