import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInAcc(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password);

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<UserCredential> signUpAcc(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
}

}