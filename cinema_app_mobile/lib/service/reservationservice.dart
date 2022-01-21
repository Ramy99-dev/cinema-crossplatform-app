import 'dart:convert';
import 'dart:io';

import 'package:cinema_app_mobile/localstorage.dart';
import 'package:cinema_app_mobile/models/reservation.dart';
import 'package:http/http.dart' as http;

void addReservation(userId, movieId, nbr) async {
  String token = await Token.getToken("token");
  await http.post(Uri.parse("http://10.0.2.2:3000/reservation"),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{"idUser": userId, "idMovie": movieId, "nbr": nbr}));
}

Future<bool> isReserved(String userId, String movieId) async {
  String token = await Token.getToken("token");
  final response = await http.get(
    Uri.parse(
        "http://10.0.2.2:3000/reservation/checkReservation/${userId}/${movieId}"),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: token,
    },
  );
  return jsonDecode(response.body);
}

Future<List<Reservation>> getUserReservation() async {
  String token = await Token.getToken("token");
  var user = await Token.decodeToken();
  print(user['id']);
  List<Reservation> reservations = [];
  final response = await http.get(
    Uri.parse(
        "http://10.0.2.2:3000/reservation/userReservations/${user['id']}"),
    headers: <String, String>{
      HttpHeaders.authorizationHeader: token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  List<dynamic> values = jsonDecode(response.body);
  if (values.isNotEmpty) {
    for (var i = 0; i < values.length; i++) {
      Map<String, dynamic> map = values[i];
      reservations.add(Reservation.fromJson(map));
    }
  }
  return reservations;
}

Future<void> deleteReservation(movieId) async {
  String token = await Token.getToken("token");
  var user = await Token.decodeToken();
  await http.delete(
    Uri.parse(
        "http://10.0.2.2:3000/reservation/deleteReservation/${user['id']}/${movieId}"),
    headers: <String, String>{
      "Authorization": token,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
