import 'dart:convert';

import 'package:http/http.dart' as http;

class UserLst {
  String category, description;

  UserLst(this.category, this.description);

  static Future<List<UserLst>> fetchData() async {
    Uri url = Uri.parse("https://fakestoreapi.com/products");

    var responseBody = await http.get(url);
    var data = (json.decode(responseBody.body)) as List;

    return data
        .map((data) => UserLst(data['category'], data['description']))
        .toList();
  }
}
