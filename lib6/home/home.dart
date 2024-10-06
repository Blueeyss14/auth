import 'package:flutter/material.dart';
import 'package:login_regist_test/auth/provider/auth_services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () async {
          final authService = Provider.of<AuthServices>(context, listen: false);
          await authService.logOut();
        }, icon: const Icon(Icons.logout)),
      ),
      body: const Center(
        child: Text("Login Successful"),
      ),
    );
  }
}
