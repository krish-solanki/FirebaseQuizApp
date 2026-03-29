import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModuleResultService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> getQuizResults(
    String moduleId,
  ) {
    return FirebaseFirestore.instance
        .collectionGroup('quizAttempts')
        .where('moduleId', isEqualTo: moduleId)
        .snapshots();
  }
}
