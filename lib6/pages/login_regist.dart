//login & regist

import 'package:flutter/material.dart';
import 'package:login_regist_test/pages/login.dart';
import 'package:login_regist_test/pages/regist.dart';

class LoginRegist extends StatefulWidget {
  const LoginRegist({super.key});

  @override
  State<LoginRegist> createState() => _LoginRegistState();
}

class _LoginRegistState extends State<LoginRegist> {
  bool toggleSwitch = true;

  void toggles() {
    setState(() {
      toggleSwitch = !toggleSwitch;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (toggleSwitch) {
      return LoginPage(onTap: toggles);
    } else {
      return RegistPage(onTap: (toggles));
    }
  }
}
