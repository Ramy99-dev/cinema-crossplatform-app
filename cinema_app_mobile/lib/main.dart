// ignore_for_file: avoid_print

import 'package:cinema_app_mobile/localstorage.dart';
import 'package:cinema_app_mobile/notification.dart';
import 'package:cinema_app_mobile/screens/book.dart';
import 'package:cinema_app_mobile/screens/home.dart';
import 'package:cinema_app_mobile/screens/login.dart';
import 'package:cinema_app_mobile/screens/movie.dart';
import 'package:cinema_app_mobile/screens/movies.dart';
import 'package:cinema_app_mobile/screens/profile.dart';
import 'package:cinema_app_mobile/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  NotificationApi.configNotificationApi();
  await Firebase.initializeApp();
  print(FirebaseMessaging.instance.getToken());
  runApp(const CinemaApp());
}

class CinemaApp extends StatelessWidget {
  const CinemaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        '/register': (context) => Register(),
        '/movie': (context) => MovieScreen(),
        '/book': (context) => Book(),
        '/movies': (context) => Movies(),
        '/profile': (context) => const Profile()
      },
    );
  }
}
