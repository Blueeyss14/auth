import 'package:flutter/material.dart';
import 'package:regist_login2/pages/login.dart';
import 'package:regist_login2/pages/regist.dart';

class LoginOrRegist extends StatefulWidget {
  const LoginOrRegist({super.key});

  @override
  State<LoginOrRegist> createState() => _LoginOrRegistState();
}

class _LoginOrRegistState extends State<LoginOrRegist> {
  bool toggles = true;

  void togglePages() {
    setState(() {
      toggles = !toggles;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggles) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
