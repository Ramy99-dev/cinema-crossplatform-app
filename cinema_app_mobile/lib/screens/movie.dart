import 'package:cinema_app_mobile/localstorage.dart';
import 'package:cinema_app_mobile/models/movie.dart';
import 'package:cinema_app_mobile/screens/book.dart';
import 'package:cinema_app_mobile/service/movieservice.dart';
import 'package:cinema_app_mobile/service/reservationservice.dart';
import 'package:cinema_app_mobile/template/nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  String idMovie = "";
  String img = "";
  String title = "";
  late String imgTag;
  late int price;
  var futureGetMovie;
  Widget BookButton = Column();
  Widget CancelReservation = Column();

  var checkreservation;
  late Widget checkreservationWidget;
  dynamic seetNumber = "Loading ...";
  double _currentSliderValue = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    idMovie = arguments['idMovie'];
    imgTag = arguments['imgTag'];

    futureGetMovie = getMovie(idMovie);
    var data = await getMovie(idMovie);
    price = data.price;
    var user = await Token.decodeToken();
    var isReservedvalue = await isReserved(user['id'], idMovie);
    setState(() {
      print("UPDATE");
      seetNumber = data.nbr;
      checkreservation = isReservedvalue;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD");
    print(checkreservation);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
      appBar: Nav(),
      body: FutureBuilder<Movie>(
          future: futureGetMovie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Movie data = snapshot.data!;
              var outputFormat = DateFormat('yyyy/MM/dd ');
              var outputDate = outputFormat.format(DateTime.parse(data.date));
              return SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: imgTag,
                        child: Image.asset(
                            "web/cinema-app-frontend/src/assets/uploads/${data.img}"),
                      ),
                      Container(
                        color: Colors.black38,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data.title,
                                style: GoogleFonts.getFont('Domine',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(data.description,
                                  style: GoogleFonts.getFont('Domine',
                                      fontSize: 17, color: Colors.white)),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text("Director : ${data.director}",
                                    style: GoogleFonts.getFont('Domine',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text("Category : ${data.category}",
                                    style: GoogleFonts.getFont('Domine',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Text("Date : ${outputDate}",
                                    style: GoogleFonts.getFont('Domine',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 10, bottom: 10, right: 50),
                                    child: Text("Price : ${data.price} \$",
                                        style: GoogleFonts.getFont('Domine',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: Text(
                                        "Seets Remaining :" +
                                            seetNumber.toString(),
                                        style: GoogleFonts.getFont('Domine',
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ],
                              ),
                              (checkreservation == null)
                                  ? Text("Loading")
                                  : (!checkreservation!)
                                      ? Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 70, right: 70),
                                              child: Slider(
                                                value: _currentSliderValue,
                                                max: 6,
                                                min: 1,
                                                divisions: 5,
                                                label: _currentSliderValue
                                                    .round()
                                                    .toString(),
                                                onChanged: (double value) {
                                                  setState(() {
                                                    _currentSliderValue = value;

                                                    snapshot.data?.price =
                                                        price * value.toInt();
                                                  });
                                                },
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                var user =
                                                    await Token.decodeToken();
                                                print(user['id']);
                                                setState(() {
                                                  if (seetNumber >
                                                      _currentSliderValue) {
                                                    seetNumber -=
                                                        _currentSliderValue
                                                            .toInt();
                                                  }

                                                  print(seetNumber);
                                                  checkreservation = true;
                                                });
                                                addReservation(
                                                    user['id'],
                                                    idMovie,
                                                    _currentSliderValue
                                                        .toInt());
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) =>
                                                        Book());
                                              },
                                              child: Text("Book",
                                                  style: GoogleFonts.getFont(
                                                      'Domine',
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white)),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.amber),
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    checkreservation = false;
                                                  });
                                                  seetNumber +=
                                                      _currentSliderValue
                                                          .toInt();

                                                  deleteReservation(idMovie);
                                                },
                                                icon: Icon(Icons.cancel)),
                                            Text("Movie Already Booked",
                                                style: GoogleFonts.getFont(
                                                    'Domine',
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white))
                                          ],
                                        )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget buildSheet() => Container();
}
