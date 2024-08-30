import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login2/provider/auth/auth_services_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() async {
    final authService = Provider.of<AuthServicesProvider>(context, listen: false);

    try {
      await authService.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid")));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Login Successful"),
            const SizedBox(height: 15),
            GestureDetector(
                onTap: signOut,
                child: Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }
}
