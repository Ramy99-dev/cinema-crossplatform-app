import 'dart:convert';
import 'dart:io';

import 'package:cinema_app_mobile/models/movie.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../localstorage.dart';

Future<List<Movie>> getAllMovies() async {
  List<Movie> movies = [];
  String token = await Token.getToken("token");
  Response response = await http.get(
      Uri.parse("http://10.0.2.2:3000/movies/all"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: token,
      });

  List<dynamic> values = jsonDecode(response.body);
  if (values.isNotEmpty) {
    for (var i = 0; i < values.length; i++) {

      Map<String, dynamic> map = values[i];
      movies.add(Movie.fromJson(map));
    }
  }

  return movies;
}

Future<List<Movie>> getMoviesByCategorie(category) async {
  List<Movie> movies = [];
  Response response;
  String token = await Token.getToken("token");
  category = category.split('_')[1];
  if (category != 'all') {
    response = await http.get(
        Uri.parse("http://10.0.2.2:3000/movies/byCategorie/${category}"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
        });
  } else {
    response = await http.get(Uri.parse("http://10.0.2.2:3000/movies/all"),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: token,
        });
  }

  List<dynamic> values = jsonDecode(response.body);
  if (values.isNotEmpty) {
    for (var i = 0; i < values.length; i++) {
      Map<String, dynamic> map = values[i];
      movies.add(Movie.fromJson(map));
    }
  }

  return movies;
}

Future<List<Movie>> getRandomMovie() async {
  String token = await Token.getToken("token");
  List<Movie> movies = [];
  Response response = await http.get(
    Uri.parse("http://10.0.2.2:3000/movies/random"),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  List<dynamic> values = jsonDecode(response.body);
  if (values.isNotEmpty) {
    for (var i = 0; i < values.length; i++) {
      print(i);
      Map<String, dynamic> map = values[i];
      movies.add(Movie.fromJson(map));
    }
  }

  return movies;
}

Future<Movie> getMovie(String idMovie) async {
  String token = await Token.getToken("token");
  Response response = await http.get(
    Uri.parse("http://10.0.2.2:3000/movies/${idMovie}"),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  return Movie.fromJson(jsonDecode(response.body));
}
