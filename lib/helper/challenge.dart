import 'dart:convert';
import 'dart:developer';

import 'package:day_challenge/assets/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'activity.dart';

class Challenge {
  final String name;
  final String description;
  final String id;
  final String color;
  final String image;

  Challenge(
      {@required this.name,
      @required this.description,
      @required this.id,
      @required this.color,
      @required this.image});

  factory Challenge.fromJson(Map<String, dynamic> json) {
    var challenge = Challenge(
        name: json['name'],
        description: json['description'],
        color: json['color'],
        id: json['_id'],
        image: json['image']);

    return challenge;
  }
}

//Function to Fetch all Challenges
Future<List<Challenge>> fetchAllChallenges() async {
  log("Fetching Challenges");
  var response = await http.get('http://192.168.0.198:3000/api/challenge');
  List<dynamic> list = json.decode(response.body);
  List<Challenge> challenges = new List();

  if (response.statusCode == 200) {
    for (int i = 0; i < list.length; ++i) {
      challenges.add(Challenge.fromJson(list[i]));
    }
    return challenges;
  } else {
    log("Exception");
  }
}

//Function to Fetch all Challenges
Future<List<Challenge>> fetchAllActualChallenges(
    List<Activity> activities) async {
  log("Fetching Actual Challenges");
  List<String> id = new List();
  for (var activity in activities) {
    id.add(activity.id);
  }

  Map data = {'challenges': id};
  var body = json.encode(data);
  var response = await http.put('$webAdress/api/challenge/activ',
      headers: {"Content-Type": "application/json"}, body: body);
  log(response.body);
  List<dynamic> list = json.decode(response.body);
  List<Challenge> challenges = new List();

  if (response.statusCode == 200) {
    for (int i = 0; i < list.length; ++i) {
      challenges.add(Challenge.fromJson(list[i]));
    }
    return challenges;
  } else {
    log("Exception");
  }
}
