import 'package:cinema_app_mobile/localstorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Nav extends StatefulWidget with PreferredSizeWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _NavState extends State<Nav> {
  var currentRoute;
  @override
  Widget build(BuildContext context) {
    currentRoute = ModalRoute.of(context)!.settings.name;

    return FutureBuilder(
        future: Token.getToken("token"),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return AppBar(
              actions: [
                currentRoute != "/profile"
                    ? IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/profile");
                        },
                        icon: const Icon(Icons.account_circle_sharp))
                    : Container(),
                IconButton(
                  onPressed: () async {
                    await Token.deleteToken('token');
                    Navigator.popAndPushNamed(context, "/login");
                  },
                  icon: const Icon(Icons.logout),
                )
              ],
              backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
              title: Text(
                "CineApp",
                style: GoogleFonts.getFont('Bebas Neue',
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              centerTitle: true,
            );
          } else {
            return AppBar(
              backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
              title: Text(
                "CineApp",
                style: GoogleFonts.getFont('Bebas Neue',
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
              centerTitle: true,
            );
          }
        });
  }
}
