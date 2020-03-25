import 'dart:convert';

import 'package:day_challenge/assets/colors.dart';
import 'package:day_challenge/blocs/BlocMainScreen.dart';
import 'package:day_challenge/events/MainScreenEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginScreenStful extends StatefulWidget {
  @override
  _LoginScreenStfulState createState() => _LoginScreenStfulState();
}

class _LoginScreenStfulState extends State<LoginScreenStful> {
  final _formKey = GlobalKey<FormState>(); //For Validaton

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final passwordController = TextEditingController();

    final nameField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'Username missing';
        }
        return null;
      },
      controller: nameController,
      obscureText: false,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );

    final passwordField = TextFormField
    (
      validator: (value) {
        if (value.isEmpty) {
          return 'Password missing';
        } else if (value.length < 5) {
          return 'Please use valid Password';
        } else {
          
          return 'Password or Username Wrong';
        }
        return null;
      },
      controller: passwordController,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Loading User Information')));
            BlocProvider.of<BlocHomeScreen>(context).add(LoginEvent(
                name: nameController.text, password: passwordController.text));
          }

          /* */
        },
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Name field
              SizedBox(
                height: 155.0,
                child: Image.asset(
                  "images/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 45.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: nameField,
              ),
              SizedBox(
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: passwordField,
              ),
              SizedBox(
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: loginButton,
              )
              //
            ],
          ),
        ),
      ),
      backgroundColor: backgroundGrey,
    );
  }
}

Future<bool> verifyUser(String name, String password) async {
  Map data = {'name': name, 'password': password};
  var body = json.encode(data);
  //Make auth call
  var response = await http.post('$webAdress/api/auth',
      headers: {"Content-Type": "application/json"}, body: body);

  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
