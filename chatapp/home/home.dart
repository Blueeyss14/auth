import 'package:c_test_firebase/pages/chat/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Auth/provider/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthServicesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Pengguna"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.signOut();
            },
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tidak ada pengguna.'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(user['email']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(receiverId: user['userId']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
