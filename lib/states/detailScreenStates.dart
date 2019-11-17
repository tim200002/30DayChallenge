/*
  All the staes of the DetailScreen
*/
import 'package:day_challenge/helper/activity.dart';
import 'package:flutter/material.dart';

abstract class DetailStates {}

//State, if Screen uninitialized, , nothing loades
class ScreenUnitialized extends DetailStates {
  @override
  String toString() => 'ScreenUninitalized';
}

//State when the loaded Activity is active
class ShowActivity extends DetailStates {
  final Activity activity;

  ShowActivity({@required this.activity});

  @override
  String toString() => 'ShowActivity';
}

//State After the Activity ic achieved
class ActivityDone extends DetailStates {
  final Activity activity;

  ActivityDone({@required this.activity});
  @override
  String toString() => 'ActivityDone';
}

//evtl. last State if whole CHallenge is fullfilled maybe new Screen
