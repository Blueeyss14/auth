import 'package:c_test_firebase/pages/chat/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout)),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }
            if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            }

            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index].data();
                return ListTile(
                  title: Text(user['email'] ?? "No Name"),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(receiverId: user['email'] ?? "No Name",),));
                  },
                );
              },
            );
          },
      ),
    );
  }
}
