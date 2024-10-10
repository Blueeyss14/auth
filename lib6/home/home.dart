import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          FirebaseAuth.instance.signOut();
        }, icon: const Icon(Icons.logout)),
      ),
      body: Center(
        child: Text("Hello World"),
      ),
    );
  }
}
