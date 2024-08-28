import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login3/auth/providers/auth_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() async {
    final authProviderService = Provider.of<AuthProviderService>(context, listen: false);

    await authProviderService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login Successful"),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: signOut,
                child: Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
