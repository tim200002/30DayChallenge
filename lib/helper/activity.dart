//This is the Class defining an Activity
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Activity {
  final String name;
  final String description;
  DateTime
      fullfilled; //Ist nicht final, sollte veränderbar sein, so das ohne erneuten API Call challenge zumindest verschwindet
  int position;
  String id;
  int length;
  String color;
  String image;

  //evtl position in complete Challenge would be also good like Day 9 of 30

  //Constructor
  Activity(
      {@required this.name,
      @required this.description,
      @required this.fullfilled,
      @required this.position,
      @required this.id,
      @required this.length,
      @required this.color,
      @required this.image});

  //Convert HTTP Answer to ActivityObject
  factory Activity.fromJson(Map<String, dynamic> json) {
    var activ = Activity(
        name: json['activity']['name'],
        description: json['activity']['description'],
        color: json['color'],
        image: json['image'],
        fullfilled: DateTime.parse(json['fullfilled']),
        position: json['position'],
        length: json['length'],
        id: json['challenge']);

    log(activ.toString());
    return activ;
  }
}

//Function to Fetch all Daily Activities
Future<List<Activity>> fetchDailyActivities() async {
  log("Fetching");
  var response =
      await http.get('http://192.168.0.198:3000/api/daily', headers: {
    "x-auth-token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZGNmZDM2N2ZlZjExNTExYTg1ZjM1MzMiLCJpc0FkbWluIjp0cnVlLCJpYXQiOjE1NzM5MDE2ODd9.ILpOWKaWmch2QrIxyioiIZQKAaO4-UJtpj_3V1bfd-c"
  });

  List<dynamic> list = json.decode(response.body);

  List<Activity> activities = new List();

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    //Thererfor iteratr over every Element in the Array and Add to list
    for (int i = 0; i < list.length; ++i) {
      activities.add(Activity.fromJson(list[i]));
    }
    return activities;
  } else {
    log("Exception");
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
