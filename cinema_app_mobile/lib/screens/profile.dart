import 'package:cinema_app_mobile/models/user.dart';
import 'package:cinema_app_mobile/service/userservice.dart';
import 'package:cinema_app_mobile/template/nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(27, 56, 100, 1),
        appBar: Nav(),
        body: FutureBuilder<User>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 90,
                          child: ClipOval(
                            child: SvgPicture.network(
                              "https://avatars.dicebear.com/api/${(snapshot.data?.gender)!.toLowerCase()}/${snapshot.data!.username}.svg?mood[]=happy",
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Username",
                        style: GoogleFonts.getFont('Domine',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        snapshot.data!.username,
                        style: GoogleFonts.getFont('Domine',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                      Text(
                        "Email",
                        style: GoogleFonts.getFont('Domine',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        snapshot.data!.email,
                        style: GoogleFonts.getFont('Domine',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      ),
                      Text(
                        "Birthday",
                        style: GoogleFonts.getFont('Domine',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        "${DateFormat('yyyy/MM/dd').format(DateTime.parse(snapshot.data!.date))}",
                        style: GoogleFonts.getFont('Domine',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber),
                      )
                    ]),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
