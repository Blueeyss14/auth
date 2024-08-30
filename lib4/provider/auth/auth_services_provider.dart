import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServicesProvider extends ChangeNotifier {
  final FirebaseAuth _authService = FirebaseAuth.instance;

  Future<UserCredential> signInAuth(String email, String password) async {
    try {
      UserCredential userCredential = await _authService.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpAuth(String email, String password) async {
    try {
      UserCredential userCredential = await _authService.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

}