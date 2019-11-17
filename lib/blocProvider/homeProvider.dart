import 'package:day_challenge/blocs/BlocMainScreen.dart';
import 'package:day_challenge/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  This is the main Screen Provider, it is the Class to Call if you want to diplay the Main Screen
  Only Task is to show the Real Main Screen widget and provide the Bloc to it
*/
class HomeScreenProvider extends StatefulWidget {
  HomeScreenProvider({Key key}) : super(key: key);

  _HomeScreenProviderState createState() => _HomeScreenProviderState();
}

class _HomeScreenProviderState extends State<HomeScreenProvider> {
  final myBloc = BlocHomeScreen();
  @override
  Widget build(BuildContext context) {
    //homeScreen is the Home Screen Widget (Scaffold)
    return BlocProvider(bloc: myBloc, child: HomeScreen());
  }
}
