import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regist_login2/provider/auth/auth_services_provider.dart';

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
    final authServices = Provider.of<AuthServicesProvider>(context, listen: false);

    try {
      await authServices.signInAuth(
          emailController.text,
          passController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid")));
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    controller : emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter Your Email',
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2
                        ),
                      ),
                      prefixIcon: const Icon(Icons.email, size: 22),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller : passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter Your Password',
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2
                        ),
                      ),
                      prefixIcon: const Icon(Icons.key, size: 22),

                    ),
                  ),
                  const SizedBox(height: 20),

                ],
              ),
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
                child: const Center(child: Text("Login")),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Haven't register yet? "),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Register Now", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
