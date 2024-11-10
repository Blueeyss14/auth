import 'dart:convert';

import 'package:http/http.dart' as http;

class UserListP {
  String category;
  double price;

  UserListP(this.category, this.price);

  static Future<List<UserListP>> fetchDataP() async {
    Uri url = Uri.parse("https://fakestoreapi.com/products");

    var responseBody = await http.get(url);
    var data = (json.decode(responseBody.body)) as List;

    return data
        .map((dataP) => UserListP(
            dataP["category"], double.parse(dataP["price"].toString())))
        .toList();
  }
}
