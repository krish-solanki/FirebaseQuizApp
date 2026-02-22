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
}
