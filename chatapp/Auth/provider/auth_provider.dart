import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServicesProvider extends ChangeNotifier {
  final FirebaseAuth _authService = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInAuth(String email, String password) async {
    try {
      UserCredential userCredential = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
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
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email,
        'userId': userCredential.user?.uid,
        'createdAt': Timestamp.now(),
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<List<Map<String, dynamic>>> getUserList() async {
    final user = _authService.currentUser;
    if (user == null) return [];

    final snapshot = await _firestore.collection('users').where('userId', isNotEqualTo: user.uid).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  String getCurrentUserId() {
    return _authService.currentUser?.uid ?? '';
  }
}
