import 'package:cinema_app_mobile/localstorage.dart';
import 'package:cinema_app_mobile/models/user.dart';
import 'package:cinema_app_mobile/service/authservice.dart';
import 'package:cinema_app_mobile/service/userservice.dart';
import 'package:cinema_app_mobile/template/nav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  IconData passwordIcon = Icons.visibility;
  bool visible = false;
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  IconData passwordIcon = Icons.visibility;
  bool visible = true;
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String err = "";
  final _formKey = GlobalKey<FormState>();
  String genderValue = 'Female';

  late DateTime _selectedDate;

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
                      onTap: _pickDateDialog,
                      controller: dateCtrl,
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: 'Birthday',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        value: genderValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            genderValue = newValue!;
                          });
                        },
                        items: <String>['Male', 'Female']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ur Email';
                        }
                        return null;
                      },
                      controller: emailCtrl,
                      decoration: const InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          labelText: 'Email',
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
                          errorStyle: TextStyle(color: Colors.white),
                          labelStyle: TextStyle(
                            color: Colors.white,
                          )),
                      obscureText: visible,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool exist = await addUser(User(
                                  username: usernameCtrl.text,
                                  email: emailCtrl.text,
                                  role: "USER",
                                  password: passwordCtrl.text,
                                  gender: genderValue,
                                  date: dateCtrl.text));
                              if (exist) {
                                setState(() {
                                  err = "Account Already Exist";
                                });
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              }
                            }
                          },
                          child: Text("Register")),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: InkWell(
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.amber)),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('/login');
                        },
                      ),
                    )
                  ],
                )),
          ),
        ));
  }

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            //which date will display when user open the picker
            firstDate: DateTime(1950),
            //what will be the previous supported year in picker
            lastDate: DateTime
                .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return;
      }
      setState(() {
        //for rebuilding the ui

        var outputFormat = DateFormat('yyyy/MM/dd ');
        var outputDate = outputFormat.format(pickedDate);
        dateCtrl.text = outputDate;
        _selectedDate = pickedDate;
      });
    });
  }
}
