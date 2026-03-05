import 'package:cloud_firestore/cloud_firestore.dart';

class StudentQuestionService {
  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchQuestions(
    String moduleId,
  ) {
    return FirebaseFirestore.instance
        .collection('modules')
        .doc(moduleId)
        .collection('questions')
        .orderBy('order')
        .snapshots();
  }
}