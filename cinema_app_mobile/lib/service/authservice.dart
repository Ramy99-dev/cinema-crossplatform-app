import 'dart:convert';

import 'package:cinema_app_mobile/localstorage.dart';
import 'package:http/http.dart' as http;

Future<bool> login(String username, String password) async {
  final response = await http.post(
      Uri.parse("http://10.0.2.2:3000/users/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}));

  if (response.body != 'Not Found') {
    Token.addToken("token", response.body);
    return true;
  } else {
    return false;
  }
}
