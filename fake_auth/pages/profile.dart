import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intern_test_pr/styles/color_style.dart';
import '../auth/auth.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  final String token;
  const ProfilePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
          future: FakeAuth.fetchUserData(token),
          builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return Center(child: CircularProgressIndicator(color: ColorStyle.whiteColor,));
           }
           if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           }
           if (!snapshot.hasData) {
             return const Center(child: Text('No Data'));
           }
           final userData = snapshot.data as Map<String, dynamic>;
           final email = userData['email'] ?? '';
           final fullName = (userData['firstName'] ?? '') + ' ' + (userData['lastName'] ?? '');
           final gender = userData['gender'] ?? '';
           final age = userData['age'] ?? '';
           final image = userData['image'] ?? '';

           return Stack(
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
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                         child: ListView(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   height: 30,
                                   width: 40,
                                   decoration: const BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.yellow,
                                   ),
                                   child: Image.network(image, fit: BoxFit.cover),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 20),
                             Row(
                               children: [
                                 Icon(Icons.person, color: ColorStyle.whiteColor, size: 20),
                                 const SizedBox(width: 20),
                                 Text("$fullName", style: TextStyle(color: ColorStyle.whiteColor),),
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                               child: Divider(height: 0.8, color: Colors.white.withOpacity(0.5)),
                             ),
                             ///email
                             Row(
                               children: [
                                 Icon(Icons.email, color: ColorStyle.whiteColor, size: 20),
                                 const SizedBox(width: 20),
                                 Text("$email", style: TextStyle(color: ColorStyle.whiteColor),),
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                               child: Divider(height: 0.8, color: Colors.white.withOpacity(0.5)),
                             ),
                             ///gender
                             Row(
                               children: [
                                 Icon(Icons.female, color: ColorStyle.whiteColor, size: 20),
                                 const SizedBox(width: 20),
                                 Text("$gender", style: TextStyle(color: ColorStyle.whiteColor),),
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                               child: Divider(height: 0.8, color: Colors.white.withOpacity(0.5)),
                             ),
                             ///age
                             Row(
                               children: [
                                 Icon(Icons.numbers, color: ColorStyle.whiteColor, size: 20),
                                 const SizedBox(width: 20),
                                 Text("$age", style: TextStyle(color: ColorStyle.whiteColor),),
                               ],
                             ),
                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 10),
                               child: Divider(height: 0.8, color: Colors.white.withOpacity(0.5)),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(height: 30),
                 ],
               ),
               SafeArea(
                 child: Align(
                   alignment: Alignment.topLeft,
                     child: IconButton(onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                     }, icon: Icon(Icons.arrow_back, color: ColorStyle.whiteColor),
                     )
                 ),
               ),
             ],
           );

          },),
    );
  }
}
