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

  static Future<String> createAttemptId(
    String studentId,
    String moduleId,
  ) async {
    final firestore = FirebaseFirestore.instance;

    final questionRef = firestore.collection('quizAttempts');

    final docRef = await questionRef.add({
      "studentId": studentId,
      "moduleId": moduleId,
      "startedAt": FieldValue.serverTimestamp(),
      "submittedAt": null,
      "score": null,
      "answers": {},
    });

    return docRef.id;
  }

  static Future<void> saveAnswer(
    String attemptId,
    String questionId,
    String selectedLetter,
  ) async {
    await FirebaseFirestore.instance
        .collection('quizAttempts')
        .doc(attemptId)
        .update({"answers.$questionId": selectedLetter});
  }

  static Future<int> submitQuiz(String attemptId, String moduleId) async {
    final firestore = FirebaseFirestore.instance;

    final attemptDoc = await firestore
        .collection('quizAttempts')
        .doc(attemptId)
        .get();
    final attemptData = attemptDoc.data();
    final studentAnswers = attemptData?['answers'] ?? {};

    final moduleQuestion = await firestore
        .collection('modules')
        .doc(moduleId)
        .collection('questions')
        .orderBy("order")
        .get();

    int score = 0;

    for (var question in moduleQuestion.docs) {
      final questionId = question.id;
      final correctAnswer = question["correctAnswer"];
      final studentAnswer = studentAnswers[questionId];

      if (studentAnswer != null && studentAnswer == correctAnswer) {
        score++;
      }
    }

    await firestore.collection('quizAttempts').doc(attemptId).update({
      "score": score,
      "submittedAt": FieldValue.serverTimestamp(),
    });
    return score;
  }
}
