import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regist_login2/home/home.dart';
import 'package:regist_login2/pages/service%20pages/login_regist.dart';

class AuthPages extends StatelessWidget {
  const AuthPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginRegist();
            }
          },
      ),
    );
  }
}
