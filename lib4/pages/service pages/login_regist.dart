import 'package:flutter/material.dart';
import 'package:regist_login2/pages/login.dart';
import 'package:regist_login2/pages/regist.dart';

class LoginRegist extends StatefulWidget {
  const LoginRegist({super.key});

  @override
  State<LoginRegist> createState() => _LoginRegistState();
}

class _LoginRegistState extends State<LoginRegist> {
  bool toggle = true;

  void toggleSwitch() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggle) {
      return LoginPage(onTap: toggleSwitch);
    } else {
      return RegistPage(onTap: toggleSwitch);
    }

  }
}
