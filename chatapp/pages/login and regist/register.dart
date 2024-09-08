import 'package:c_test_firebase/Auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistPage extends StatefulWidget {
  final Function()? onTap;
  const RegistPage({super.key, required this.onTap});

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  void signUp() async {
    final authService = Provider.of<AuthServicesProvider>(context, listen: false);

    if (passController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password do not match")));
      return;
    }

    try {
      await authService.signUpAuth(
          emailController.text, passController.text);
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

                  TextField(
                    controller: confirmPassController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirmation Password',
                      hintText: 'Enter Your Confirmation Password',
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
                ],
              ),
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
                child: const Center(child: Text("Register")),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Have an Account? "),
                GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Login Now", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}