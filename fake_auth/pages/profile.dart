import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intern_test_pr/styles/color_style.dart';
import '../auth/auth.dart';

class ProfilePage extends StatelessWidget {
  final String token;
  const ProfilePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: ColorStyle.blueColor,
        title: const Text("User"),
      ),
      body: FutureBuilder(
          future: FakeAuth.fetchUserData(token),
          builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
             return const Center(child: CircularProgressIndicator());
           }
           if (snapshot.hasError) {
             return Center(child: Text('Error: ${snapshot.error}'));
           }
           if (!snapshot.hasData) {
             return const Center(child: Text('No Data'));
           }
           final userData = snapshot.data as Map<String, dynamic>;
           final username = userData['username'] ?? '';
           final email = userData['email'] ?? '';
           final fullName = (userData['firstName'] ?? '') + ' ' + (userData['lastName'] ?? '');
           final gender = userData['gender'] ?? '';
           final age = userData['age'] ?? '';
           final image = userData['image'] ?? '';

           return Stack(
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
                 children: [
                   Container(
                     width: MediaQuery.of(context).size.width,
                     height: MediaQuery.of(context).size.height / 2 - 150,
                     color: Colors.transparent,
                     child: Stack(
                       children: [
                         Column(
                           children: [
                             Flexible(
                               child: Container(
                                 decoration: const BoxDecoration(
                                   borderRadius: BorderRadius.only(
                                     bottomRight: Radius.circular(150),
                                     bottomLeft: Radius.circular(150),
                                   ),
                                   color: Colors.transparent,
                                 ),
                               ),
                             ),
                             Flexible(
                                 child: Container(
                                   decoration: BoxDecoration(
                                     borderRadius: const BorderRadius.only(
                                       topRight: Radius.circular(40),
                                       topLeft: Radius.circular(40),
                                     ),
                                     color: ColorStyle.blueColor
                                   ),
                                 ),
                             ),
                           ],
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           children: [
                             Center(child: Text("$username", style: TextStyle(fontSize: 30, color: ColorStyle.whiteColor))),
                           ],
                         ),
                         Center(
                             child: Container(
                               width: 200,
                               height: 200,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(100),
                                 color: Colors.blue,
                               ),
                               child:  Image.network(image, fit: BoxFit.cover),
                             ),
                         ),
                       ],
                     ),
                   ),

                   Flexible(
                     child: Container(
                       padding: const EdgeInsets.symmetric(horizontal: 30),
                       width: double.infinity,
                       color: ColorStyle.blueColor,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(height: 20),
                           ///fullName
                           Row(
                             children: [
                               Icon(Icons.person, color: ColorStyle.whiteColor),
                               const SizedBox(width: 20),
                               Text("$fullName", style: TextStyle(color: ColorStyle.whiteColor),),
                             ],
                           ),
                           Divider(color: ColorStyle.whiteColor),
                           const SizedBox(height: 10),
                           ///email
                           Row(
                             children: [
                               Icon(Icons.email, color: ColorStyle.whiteColor),
                               const SizedBox(width: 20),
                               Text("$email", style: TextStyle(color: ColorStyle.whiteColor),),
                             ],
                           ),
                           Divider(color: ColorStyle.whiteColor),
                           const SizedBox(height: 10),
                           ///gender
                           Row(
                             children: [
                               Icon(Icons.female, color: ColorStyle.whiteColor),
                               const SizedBox(width: 20),
                               Text("$gender", style: TextStyle(color: ColorStyle.whiteColor),),
                             ],
                           ),
                           Divider(color: ColorStyle.whiteColor),
                           const SizedBox(height: 10),
                           ///age
                           Row(
                             children: [
                               Icon(Icons.numbers, color: ColorStyle.whiteColor),
                               const SizedBox(width: 20),
                               Text("$age", style: TextStyle(color: ColorStyle.whiteColor),),
                             ],
                           ),
                           Divider(color: ColorStyle.whiteColor),
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           );

          },),
    );
  }
}
