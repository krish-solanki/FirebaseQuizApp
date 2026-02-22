import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterService {
  static Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw "All fields are required";
      }

      // 1️⃣ Firebase Auth
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "uid": uid,
        "name": name,
        "email": email,
        "role": "student",
        "code": 123,
        "createdAt": FieldValue.serverTimestamp(),
      });

    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw "Email already registered";
      } else if (e.code == 'weak-password') {
        throw "Password is too weak";
      } else {
        throw e.message ?? "Registration failed";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}