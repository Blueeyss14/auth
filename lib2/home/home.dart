import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login2/auth/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() async {
    final authService = Provider.of<AuthServices>(context, listen: false);

    await authService.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: signOut,
                child: const Icon(Icons.logout)),
          ),]
      ),
      body: const Center(
        child: Text("Success"),
      ),
    );
  }
}
