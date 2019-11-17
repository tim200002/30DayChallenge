import 'package:day_challenge/helper/activity.dart';
import 'package:flutter/material.dart';

abstract class DetailEvents {}

//Event to change State from Active to done
class MakeDoneEvent extends DetailEvents {
  //Id of the Entry in the Database
  Activity activity;
  MakeDoneEvent({@required this.activity});
}

//First Event to get called -> Sets State to show Activity
class ShowActivityEvent extends DetailEvents {
  Activity activity;
  ShowActivityEvent({@required this.activity});
}
