import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServicesProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore  = FirebaseFirestore.instance;

  Future<UserCredential> signInAccount(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);

      await _firebaseFirestore.collection('users').doc(userCredential.user?.uid).set({
        'email' : email,
        'userId' : userCredential.user?.uid,
        'createdAt' : Timestamp.now,
      });
      return userCredential;

    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpAccount(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await _firebaseFirestore.collection('users').doc(userCredential.user?.uid).set({
        'email' : email,
        'userId' : userCredential.user?.uid,
        'createdAt' : Timestamp.now,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<List<Map<String, dynamic>>> getUserList() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return [];
    }

    final snapshot = await _firebaseFirestore.collection('users').where('userId', isNotEqualTo: user.uid).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  String getCurrentUserId() {
    return _firebaseAuth.currentUser?.uid ?? '';
  }

}