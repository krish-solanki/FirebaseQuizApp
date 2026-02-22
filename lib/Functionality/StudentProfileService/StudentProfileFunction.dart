import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StudentProfileFunction {
  static Future<Map<String, String>?> getUserDetails() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (!doc.exists) return null;

    final data = doc.data()!;

    return {"name": data["name"] ?? "", "email": data["email"] ?? ""};
  }
}