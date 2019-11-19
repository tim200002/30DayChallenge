import 'package:day_challenge/screens/homeScreen2.dart';
import 'package:day_challenge/blocs/BlocMainScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //The Bloc Provider which shows the Main Screen
    return BlocProvider<BlocHomeScreen>(
        builder: (BuildContext context) => BlocHomeScreen(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeScreen()));
  }
}
