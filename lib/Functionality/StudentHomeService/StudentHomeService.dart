import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentHomeService {
  static Future<String> getStudentName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) return "Student";

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      print("USER DATA: ${doc.data()}"); // 🔥 ADD THIS
      return doc.data()?['name'] ?? "Student";
    } catch (e) {
      return "Student";
    }
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllQuiz() {
    return FirebaseFirestore.instance
        .collection('modules')
        .orderBy('startDate')
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCompletedQuizzes(
    String studentId,
  ) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(studentId)
        .collection('quizAttempts')
        .snapshots();
  }
}
