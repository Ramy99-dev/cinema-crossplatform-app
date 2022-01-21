import 'package:cinema_app_mobile/models/reservation.dart';
import 'package:cinema_app_mobile/service/reservationservice.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  num total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
      body: Container(
        child: Card(
          color: Colors.black.withOpacity(0.5),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text("Reservation",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                FutureBuilder<List<Reservation>>(
                    future: getUserReservation(),
                    builder: (context, snapshot) {
                      print(snapshot.hasData);
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: snapshot.data!.map((r) {
                                  total += r.movie['prix'] * r.nbr;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/movie',
                                        arguments: {
                                          'idMovie': r.movie['_id'],
                                          "imgTag": 'img'
                                        },
                                      );
                                    },
                                    child: Row(children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text("Movie Name : ",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.amber,
                                              )),
                                          Text("Price : ",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.amber,
                                              )),
                                          Text("Person : ",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.amber,
                                              )),
                                          Text("Duration : ",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.amber,
                                              )),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(r.movie['titre'],
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              )),
                                          Text("${r.movie['prix'] * r.nbr} \$",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              )),
                                          Text("${r.nbr} ",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              )),
                                          Text("${r.movie['duree']}",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              )),
                                        ],
                                      )
                                    ]),
                                  );
                                }).toList()),
                            Container(
                                alignment: Alignment.center,
                                child: Text("Total : ${total} \$ ",
                                    style: GoogleFonts.getFont('Domine',
                                        fontSize: 17, color: Colors.white))),
                          ],
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.amber),
                      onPressed: () {},
                      child: Text("Confirm",
                          style: GoogleFonts.getFont('Domine',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
