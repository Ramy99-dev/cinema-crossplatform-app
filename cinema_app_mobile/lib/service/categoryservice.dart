import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../localstorage.dart';

Future<List<dynamic>> getMoviesCategory() async {
  String token = await Token.getToken("token");
  List<dynamic> categories = [];
  final response = await http.get(
    Uri.parse("http://10.0.2.2:3000/movies/categories"),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  List<dynamic> values = jsonDecode(response.body);
  Set<String> categ = {};
  if (values.isNotEmpty) {
    for (var i = 0; i < values.length; i++) {
      categ.add(jsonEncode(values[i]['categorie']));
    }
  }
  List arr = categ.toList();
  for (int i = 0; i < arr.length; i++) {
    categories.add(jsonDecode(arr[i]));
  }
  categories.add({'_id': 'all', 'nom': 'All movies'});


  return categories;
}
