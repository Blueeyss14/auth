import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intern_test_pr/model/ui_model.dart';
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

  final List<UiModel> uiModel = UiModel.dataUiModel();

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
      backgroundColor: ColorStyle.darkBlueColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('asset/images/image3.jpg', fit: BoxFit.cover),
          
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: MediaQuery.of(context).size.height / 2 - 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: emailController,
                        style: TextStyle(color: ColorStyle.whiteColor),
                        cursorColor: ColorStyle.whiteColor,
                        decoration: InputDecoration(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          prefixIcon: const Icon(Icons.person, size: 20),
                          prefixIconColor: ColorStyle.whiteColor,
                          hintText: "Username",
                          hintStyle: TextStyle(color: ColorStyle.whiteColor, fontWeight: FontWeight.normal),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(height: 0.8, color: Colors.white.withOpacity(0.5)),
                      ),
                      TextField(
                        obscureText: isObscureText ? false : true,
                        style: TextStyle(color: ColorStyle.whiteColor),
                        cursorColor: ColorStyle.whiteColor,
                        controller: passController,
                        decoration: InputDecoration(
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          prefixIcon: const Icon(Icons.key, size: 20),
                          prefixIconColor: ColorStyle.whiteColor,
                          suffixIcon: IconButton(
                              onPressed: _togglePassword,
                              icon: isObscureText ? Icon(Icons.visibility, size: 20, color: ColorStyle.whiteColor,)
                                  : Icon(Icons.visibility_off, size: 20, color: ColorStyle.whiteColor)
                          ),
                          suffixIconColor: ColorStyle.whiteColor,
                          hintText: "Password",
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                          hintStyle: TextStyle(color: ColorStyle.whiteColor, fontWeight: FontWeight.normal),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(height: 0.8, color: Colors.white.withOpacity(0.5)),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (int i = 0; i < uiModel.length; i++)
                          uiModel[i].logo,
                        ],
                      ),
                    ],
                  ),
                ),
              ),



              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _login,
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorStyle.whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 0.2,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Center(child: Text("Login to Play", style: TextStyle(fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7), fontSize: 18),)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 45,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorStyle.whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 0.2,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.question_mark, color: Colors.black.withOpacity(0.7),),
                    ),

                  ],
                ),
              )
            ],
          ),
          if (isLoading)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: ColorStyle.whiteColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
