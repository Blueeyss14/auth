import 'package:flutter/material.dart';
import 'package:regist_login3/pages/login.dart';
import 'package:regist_login3/pages/register.dart';

class LoginAndRegist extends StatefulWidget {
  const LoginAndRegist({super.key});

  @override
  State<LoginAndRegist> createState() => _LoginAndRegistState();
}

class _LoginAndRegistState extends State<LoginAndRegist> {
  bool toggle = true;

  void switchToggle() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggle) {
      return LoginPage(onTap: switchToggle);
    } else {
      return RegisterPage(onTap: switchToggle);
    }
  }
}
