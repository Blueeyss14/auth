import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login2/auth/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthServices>(context, listen: false);

    try {
      await authService.inEmailAndPassword(
          emailController.text,
          passController.text
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not found')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: passController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: signIn,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                    child: Text("Login")),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not registered yet? "),
                GestureDetector(
                  onTap: widget.onTap,
                    child: Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
