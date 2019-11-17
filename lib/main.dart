import 'package:day_challenge/blocProvider/homeProvider.dart';
import 'package:day_challenge/screens/loginScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        //Start Screen of the App
        //home: homeScreen(),
        // home: detailScreen(),
        //home: testScreen(),

        //The Bloc Provider which shows the Main Screen
        //home: MainScreenProvider(),
        home: HomeScreenProvider());
    //home: LoginScreen());
  }
}
