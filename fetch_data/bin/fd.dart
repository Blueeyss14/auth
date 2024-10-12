import 'dart:convert';
import 'package:http/http.dart' as http;

class DataAPI {
  String email, firstName, lastName;

  DataAPI({
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  static Future<List<DataAPI>> fetchData() async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=2");

    var responsebody = await http.get(url);
    var data = (json.decode(responsebody.body))["data"] as List;

    return data
        .map((user) => DataAPI(
              email: user['email'],
              firstName: user['first_name'],
              lastName: user['last_name'],
            ))
        .toList();
  }
}

void main() async {
  List<DataAPI> dataAPI = await DataAPI.fetchData();

  for (int i = 0; i < dataAPI.length; i++) {
    print('Email: ${dataAPI[i].email}');
  }
}
