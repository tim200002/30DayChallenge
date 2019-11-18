/*
  All the States of the Main screen Block
*/

import 'package:day_challenge/events/MainScreenEvents.dart';
import 'package:day_challenge/helper/activity.dart';
import 'package:flutter/semantics.dart';

abstract class MainScreenState {
  //? What does the next Line do, maybe optional
  MainScreenState([List props = const []]);
}

//Unitialized before first use
class MainUninitialized extends MainScreenState {
  @override
  String toString() => 'ActivityUninitialized';
}

//State when post loaded, saves list of actual activities
class MainLoaded extends MainScreenState {
  //List of Activities
  final List<Activity> activities;
  String progressText;
  double progress;
  List<Activity> actualActivities;

  //Constructor
  MainLoaded(
      {this.activities,
      this.progress,
      this.progressText,
      this.actualActivities})
      : super(activities);

  //copy Construcor
  MainLoaded copyWith({
    List<Activity> activities,
  }) {
    return MainLoaded(activities: this.activities);
  }

  //Delete a single Item from the actualActivity List found by ID -> therefor I need a new Event like delete
  void delete(int challengeID) {
    for (Activity activity in actualActivities) {
      if (activity.id.toString() == challengeID) {
        activities.remove(activity);
      }
    }
  }

  @override
  String toString() => 'Post Loaded{activities: ${activities.length}';
}

class ShowLoginScreen extends MainScreenState {
  @override
  String toString() => 'ShowLoginScreen';
}

class LoginOrRegister extends MainScreenState {}

//State for navigating to Detail Screen
//Does this really need a state
class NavigateToDetailScreen extends MainScreenState {
  @override
  String toString() => 'NavigateToDetailScreen';
}
