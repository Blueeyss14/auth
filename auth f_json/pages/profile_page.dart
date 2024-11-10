import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder(
        future: _fetchUserData(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Data'));
          } else {
            final userData = snapshot.data as Map<String, dynamic>;

            print('User Data: $userData');

            final username = userData['username'] ?? 'N/A';
            final email = userData['email'] ?? 'N/A';
            final name = userData['name'] ?? 'N/A';
            final imageUrl = userData['image'] ?? '';

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(imageUrl),
                  const SizedBox(height: 16),
                  Text('Name: $username'),
                  Text('Email: $email'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchUserData(String? token) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/users/me'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
