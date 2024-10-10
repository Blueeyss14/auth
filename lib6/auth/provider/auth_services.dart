import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServiceP extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInMe(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);

      return userCredential;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signUpMe(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      return userCredential;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}