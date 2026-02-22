import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomefService {
  static Future<int> totalExams() async {
    try {
      final sanpshot = await FirebaseFirestore.instance
          .collection('modules')
          .count()
          .get();

      return sanpshot.count ?? 0;
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<int> totalStudents() async {
    try {
      final sanpshot = await FirebaseFirestore.instance
          .collection('users')
          .count()
          .get();

      return sanpshot.count ?? 0;
    } catch (e) {
      throw e.toString();
    }
  }
}
