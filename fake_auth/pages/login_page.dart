import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_test_pr/pages/profile.dart';
import 'package:intern_test_pr/styles/color_style.dart';
import '../url/dummy_url.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  bool isLoading = false;
  bool isObscureText = false;

  void _togglePassword() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  void _login() async {
    final username = emailController.text.trim();
    final password = passController.text;

    if (username.isNotEmpty && username.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      emailController.clear();
      passController.clear();

      try {
        Uri url = Uri.parse(DummyUrl.loginURL);
        var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }),
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final token = data['token'];
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(token: token,),));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: ${response.statusCode}')));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Fill the textfield")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'asset/images/image1.jpg',
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Container(
                  alignment : Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 420,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF3E4269),
                          Color(0xFF549BAD),
                        ],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft
                    )
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailController,
                              style: TextStyle(color: ColorStyle.whiteColor),
                              cursorColor: ColorStyle.whiteColor,
                              decoration: InputDecoration(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                prefixIcon: const Icon(Icons.person),
                                prefixIconColor: ColorStyle.whiteColor,
                                hintText: "Username",
                                hintStyle: TextStyle(color: ColorStyle.whiteColor, fontWeight: FontWeight.normal),
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(height: 1),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              obscureText: isObscureText ? false : true,
                              style: TextStyle(color: ColorStyle.whiteColor),
                              cursorColor: ColorStyle.whiteColor,
                              controller: passController,
                              decoration: InputDecoration(
                                hoverColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                prefixIcon: const Icon(Icons.key),
                                prefixIconColor: ColorStyle.whiteColor,
                                suffixIcon: IconButton(
                                    onPressed: _togglePassword,
                                    icon: isObscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                                ),
                                suffixIconColor: ColorStyle.whiteColor,
                                hintText: "Password",
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                                hintStyle: TextStyle(color: ColorStyle.whiteColor, fontWeight: FontWeight.normal),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(height: 1),
                            ),

                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: _login,
                              child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: ColorStyle.whiteColor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Center(child: Text("Login", style: TextStyle(color: Colors.grey[10]),)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
            if (isLoading)
              const Center(child: CircularProgressIndicator(),),
        ],
      ),
    );
  }
}
