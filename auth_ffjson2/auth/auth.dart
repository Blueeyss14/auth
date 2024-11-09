import 'dart:convert';
import 'package:http/http.dart' as http;
import '../url/dummy_url.dart';

class FakeAuth {

  static Future<Map<String, dynamic>> fetchUserData(String? token) async {
    Uri url = Uri.parse(DummyUrl.userURL);
    final response = await http.get(url,
      headers: <String, String> {
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }
}