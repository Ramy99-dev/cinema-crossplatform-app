import 'package:cinema_app_mobile/localstorage.dart';
import 'package:cinema_app_mobile/models/movie.dart';
import 'package:cinema_app_mobile/service/movieservice.dart';
import 'package:cinema_app_mobile/template/nav.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';

import '../notification.dart';
import 'book.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        NotificationApi.flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                NotificationApi.channel.id,
                NotificationApi.channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = message.notification!.android!;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

    Token.getToken("token").then((value) => {
          print(value),
          if (value == null)
            {Navigator.of(context).pushReplacementNamed('/login')}
        });
  }

  Future<void> refresh() {
    setState(() {});
    return getRandomMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
        appBar: Nav(),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(27, 56, 100, 1),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Book());
          },
          label: Text("Book List"),
          icon: Icon(Icons.bookmark),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Most Loved",
                            style: GoogleFonts.getFont('Domine',
                                fontSize: 17, color: Colors.white)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/movies');
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                      label: Text("Others"),
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(27, 56, 100, 1)),
                    )
                  ],
                ),
                FutureBuilder<List<Movie>>(
                    future: getAllMovies(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print(snapshot.data);
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 400.0,
                            autoPlay: true,
                          ),
                          items: snapshot.data!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/movie',
                                      arguments: {
                                        'idMovie': i.id,
                                        "imgTag": 'movie-img-${i.img}'
                                      },
                                    );
                                  },
                                  child: Hero(
                                    tag: 'movie-img-${i.img}',
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "web/cinema-app-frontend/src/assets/uploads/${i.img}"),
                                              fit: BoxFit.cover),
                                        ),
                                        child: Container(
                                          alignment: Alignment.center,
                                          color: Color.fromRGBO(0, 0, 0, 0.7),
                                          child: Material(
                                            color: Colors.white.withOpacity(0),
                                            child: Text(
                                              i.title,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                FutureBuilder<List<Movie>>(
                    future: getRandomMovie(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${snapshot.data?.first.category}",
                                        style: GoogleFonts.getFont('Domine',
                                            fontSize: 17, color: Colors.white)),
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed('/movies');
                                  },
                                  icon: Icon(Icons.arrow_forward_ios),
                                  label: Text("Others"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(27, 56, 100, 1)),
                                )
                              ],
                            ),
                            CarouselSlider(
                              options: CarouselOptions(height: 400.0),
                              items: snapshot.data!.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          '/movie',
                                          arguments: {
                                            'idMovie': i.id,
                                            "imgTag": 'movie-categ-img-${i.img}'
                                          },
                                        );
                                      },
                                      child: Hero(
                                        tag: 'movie-categ-img-${i.img}',
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "web/cinema-app-frontend/src/assets/uploads/${i.img}"),
                                                  fit: BoxFit.cover),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.7),
                                              child: Material(
                                                color:
                                                    Colors.white.withOpacity(0),
                                                child: Text(
                                                  i.title,
                                                  style: const TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            )
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
              ],
            ),
          ),
        ));
  }
}
