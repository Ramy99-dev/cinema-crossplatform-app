import 'package:cinema_app_mobile/localstorage.dart';
import 'package:cinema_app_mobile/service/authservice.dart';
import 'package:cinema_app_mobile/template/nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  IconData passwordIcon = Icons.visibility;
  bool visible = true;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String err = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(27, 56, 100, 1),
        appBar: Nav(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/cinemaLogo.png",
                      width: 250,
                    ),
                    Text(
                      err,
                      style: GoogleFonts.getFont('Oswald',
                          fontSize: 20, color: Colors.amber),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ur username';
                        }
                        return null;
                      },
                      controller: usernameCtrl,
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      obscureText: false,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ur password';
                        }
                        return null;
                      },
                      controller: passwordCtrl,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              color: Color.fromRGBO(255, 255, 255, 0.7),
                              onPressed: () {
                                if (visible == true) {
                                  setState(() {
                                    visible = false;
                                    passwordIcon = Icons.visibility_off;
                                  });
                                } else {
                                  setState(() {
                                    visible = true;
                                    passwordIcon = Icons.visibility;
                                  });
                                }
                              },
                              icon: Icon(passwordIcon)),
                          errorStyle: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          )),
                      obscureText: visible,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (await login(
                                      usernameCtrl.text, passwordCtrl.text) ==
                                  false) {
                                setState(() {
                                  err = "Account not found";
                                });
                              } else {
                                Token.connected = true;
                                Navigator.of(context)
                                    .pushReplacementNamed('/home');
                              }
                            }
                          },
                          child: const Text("Login")),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        child: const Text("Create Account",
                            style: TextStyle(color: Colors.amber)),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/register');
                        },
                      ),
                    )
                  ],
                )),
          ),
        ));
  }
}
