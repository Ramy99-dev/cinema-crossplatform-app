import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:cinema_app_mobile/models/user.dart';
import 'package:http/http.dart';

import '../localstorage.dart';

Future<bool> addUser(User user) async {
  Response response = await http.post(Uri.parse("http://10.0.2.2:3000/users/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": user.username,
        "email": user.email,
        "password": user.password,
        "role": 'USER',
        "gender": user.gender,
        "date": user.date.toString()
      }));

  return jsonDecode(response.body)['err'];
}

Future<User> getUser() async {
  String token = await Token.getToken("token");
  Map user = await Token.decodeToken();
  String userId = user['id'];
  Response response = await http.get(
    Uri.parse("http://10.0.2.2:3000/users/${userId}"),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

 
  return User.fromJson(jsonDecode(response.body));
}
