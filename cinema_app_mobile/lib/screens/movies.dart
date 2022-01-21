
import 'package:cinema_app_mobile/models/movie.dart';
import 'package:cinema_app_mobile/service/categoryservice.dart';
import 'package:cinema_app_mobile/service/movieservice.dart';
import 'package:cinema_app_mobile/template/nav.dart';
import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  String dropdownValue = 'All movies_all';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Nav(),
        backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
        body: Column(
          children: [
            FutureBuilder<List<dynamic>>(
                future: getMoviesCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DropdownButton<String>(
                      dropdownColor: Colors.black,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: snapshot.data!
                          .map<DropdownMenuItem<String>>((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: "${value['nom']}_${value['_id']}",
                          child: Text(value['nom']),
                        );
                      }).toList(),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            Expanded(
              child: FutureBuilder<List<Movie>>(
                  future: getMoviesByCategorie(dropdownValue),
                  builder: (context, snapshot) {
                    print(snapshot.hasData);
                    if (snapshot.hasData) {
                      return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        children: snapshot.data!.map((movie) {
                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/movie',
                                  arguments: {
                                    'idMovie': movie.id,
                                    "imgTag": 'movie-img-${movie.img}'
                                  },
                                );
                              },
                              child: Card(
                                  color: Color.fromRGBO(27, 56, 100, 0.3),
                                  child: Hero(
                                    tag: 'movie-img-${movie.img}',
                                    child: Image.asset(
                                        "web/cinema-app-frontend/src/assets/uploads/${movie.img}"),
                                  )));
                        }).toList(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ));
  }
}
