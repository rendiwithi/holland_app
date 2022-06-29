import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:holland/data/static.dart';

class User {
  int id;
  String username;
  String password;
  String name;
  String role;
  String token;
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.role,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> object) {
    return User(
      id: object["id"],
      name: object["nama"],
      token: object["token"],
      password: object["password"],
      username: object["username"],
      role: object["role"]["nama"],
    );
  }

  static Future<User> connectToApi(
      {required String username, required String password}) async {
    String apiUrl = "$baseUrl/user/login";

    var apiResult = await http.post(Uri.parse(apiUrl),
        body: {"username": username, "password": password});
    var jsonObject = json.decode(apiResult.body);
    if (jsonObject["status"] == false) {
      return User(
        id: 0,
        name: "",
        token: "",
        role: "",
        password: "",
        username: "",
      );
    }
    return User.fromJson(jsonObject["data"]);
  }
}
