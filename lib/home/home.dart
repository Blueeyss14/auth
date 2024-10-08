import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() {
    final authService = Provider.of<AuthServices>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: signOut,
            child: const Icon(Icons.logout)),
      ),
      body: Center(
        child: Text("Anda Sudah Login"),
      ),
    );
  }
}
