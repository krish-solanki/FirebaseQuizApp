import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModuleResultService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getQuizResults(
    String moduleId,
  ) {
    return FirebaseFirestore.instance
        .collection('modules')
        .doc(moduleId)
        .collection('quizAttempts')
        .snapshots();
  }
}
