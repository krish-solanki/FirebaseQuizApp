import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_quiz_app/AuthCheck.dart';
import 'package:firebase_quiz_app/User/Admin/Admin_Home.dart';
import 'package:firebase_quiz_app/User/Authentication/Login.dart';
import 'package:firebase_quiz_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(423, 930),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const AuthCheck(),
    );
  }
}
