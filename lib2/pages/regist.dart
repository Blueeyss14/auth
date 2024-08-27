import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login2/auth/providers/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  void signUp() async {
    final authService = Provider.of<AuthServices>(context, listen: false);

    if (passController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password do not match")));
      return;
    }

    try {
      await authService.upEmailAndPassword(
          emailController.text,
          passController.text,
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

            TextField(
              controller: confirmPassController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: "Confirm Password",
                hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
              ),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            GestureDetector(
              onTap: signUp,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                    child: Text("Regist")),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an account? "),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Login Now", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
