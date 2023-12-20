import 'package:adishankara_calender/dependencies/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (kDebugMode) {
        print("registered user $userCredential");
      }
      final user = userCredential.user!.email;
      showToast(msg: "Registerd user $user");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(msg: "Email is alrady in Use");
      } else {
        showToast(msg: "Something went wrong Errorcode: ${e.code}");
      }
    }
    return null;
  }

  Future<User?> signinpwithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (kDebugMode) {
        print("Logged_in user $userCredential");
      }
      //showToast(msg: "Logged in as $email");

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("not registered ${e.code}");
      }
      if (e.code == 'invalid-login-credentials') {
        showToast(msg: "Invalid username or password");
      } else {
        showToast(msg: "Something went wrong : ${e.code}");
      }
    }
    return null;
  }
}
