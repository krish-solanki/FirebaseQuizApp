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
    String title,
  ) async {
    final firestore = FirebaseFirestore.instance;

    final docRef = await firestore.collection('quizAttempts').add({
      "studentId": studentId,
      "moduleId": moduleId,
      "startedAt": FieldValue.serverTimestamp(),
      "submittedAt": null,
      "score": null,
      "answers": {},
    });

    final attemptId = docRef.id;

    await firestore
        .collection('users')
        .doc(studentId)
        .collection('quizAttempts')
        .doc(attemptId)
        .set({
          "quizName": title,
          "moduleId": moduleId,
          "marks": null,
          "attemptDate": FieldValue.serverTimestamp(),
        });

    final snapshot = await firestore
        .collection('modules')
        .doc(moduleId)
        .collection('result')
        .get();

    int totalAttendees = snapshot.docs.length;

    await firestore
        .collection('modules')
        .doc(moduleId)
        .collection('result')
        .doc(attemptId)
        .set({'studentId': studentId, 'marks': 0});

    await firestore.collection('modules').doc(moduleId).update({
      'totalAttendees': totalAttendees + 1,
    });

    return attemptId;
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

  static Future<int> submitQuiz(
    String attemptId,
    String moduleId,
    String studentId,
  ) async {
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

    await firestore
        .collection('modules')
        .doc(moduleId)
        .collection('result')
        .doc(attemptId)
        .update({'marks': score});

    await firestore
        .collection('users')
        .doc(studentId)
        .collection('quizAttempts')
        .doc(attemptId)
        .update({"marks": score});
    return score;
  }

  static Future<bool> isAttempted(String studentId, String moduleId) async {
    final firestore = FirebaseFirestore.instance;

    final snapshot = await firestore
        .collection('users')
        .doc(studentId)
        .collection('quizAttempts')
        .where('moduleId', isEqualTo: moduleId)
        .get();

    return snapshot.docs.isNotEmpty;
  }
}
