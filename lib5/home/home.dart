import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login2/providers/auth/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Successful"),
            IconButton(
                onPressed: () {
                  final authService = Provider.of<AuthServicesProvider>(context, listen: false);
                  authService.signOut();
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
