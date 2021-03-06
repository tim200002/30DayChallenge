//Events fot the activity Bloc

import 'package:flutter/widgets.dart';

abstract class MainEvents {}

//Events to fetch all activities in the Databse
class FetchAll extends MainEvents {}

//Event to go to new Screen doesnt work at the moment
class GoToDetailScreen extends MainEvents {}

//Event to go to the Login Screen
class GoToLoginScreen extends MainEvents {}

//Event to check if Login
class CheckForLogin extends MainEvents {}

//Login Events
class LoginEvent extends MainEvents {
  String name;
  String password;
  LoginEvent({@required this.name, @required this.password});
}

//Register Event
class RegisterEvent extends MainEvents {
  String name;
  String password;
  RegisterEvent({@required this.name, @required this.password});
}

//Logout
class LogoutEvent extends MainEvents {}

//Loading
class LoadingEvent extends MainEvents {}
