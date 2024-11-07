import 'dart:convert';

import 'package:http/http.dart' as http;

class UserList {
  String firstName, lastName, email;

  UserList(this.firstName, this.lastName, this.email);

  static Future<List<UserList>> fetchData() async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=2");
    var responseBody = await http.get(url);
    var data = (json.decode(responseBody.body))["data"] as List;

    return data
        .map((data) =>
            UserList(data['first_name'], data['last_name'], data['email']))
        .toList();
  }
}
