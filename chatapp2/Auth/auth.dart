import 'package:c_test_firebase/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/login and regist/login_regist.dart';

class AuthPages extends StatelessWidget {
  const AuthPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginRegist();
          }
        },
      ),
    );
  }
}
