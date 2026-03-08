import 'package:cloud_firestore/cloud_firestore.dart';

class StudentCompleteQuiz {
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchStudentCompletedQuizzes(
    String studentId,
  ) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(studentId)
        .collection('quizAttempts')
        .orderBy('attemptDate', descending: true)
        .snapshots();
  }
}