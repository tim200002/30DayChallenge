/*
  Bloc to handle all the Sates, Database Querys etc. of the Main Page

*/

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:day_challenge/events/MainScreenEvents.dart';
import 'package:day_challenge/helper/activity.dart';
import 'package:day_challenge/states/MainScreenStates.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class BlocHomeScreen extends Bloc<MainEvents, MainScreenState> {
  //These functions can be called from outside

  //Update Screen
  /* void update() {
    dispatch(FetchAll());
  }
  

  //Go to detail Screen by parsing the information about
  //the presses Bloc to this Screen
  void detailScreen() {
    dispatch(GoToDetailScreen());
  }

  void deleteActivity() {}*/

  //Beginning State,
  //Activity Uninitialized shows loading Screen
  //Try to connect and get Information if logged In, show Informatio
  //Else show logging inn Screen

  String jwtToken;
  @override
  MainScreenState get initialState => MainUninitialized();

  //Maps Events, to States here is where the real logic happends
  @override
  Stream<MainScreenState> mapEventToState(MainEvents event) async* {
    try {
      //Fetches all Activities from Repository and changes State to loaded
      if (event is FetchAll) {
        //Make API Call
        List<Activity> activities = await fetchDailyActivities(jwtToken);

        List<Activity> actualActivities = getActualActivities(activities);
        double progress = getProgress(activities);
        String progressString = getProgressString(activities);
        //Then starting Loaded State with all activities

        //yield ShowLoginScreeen();
        yield MainLoaded(
            activities: activities,
            progress: progress,
            progressText: progressString,
            actualActivities: actualActivities);
      }

      //Transition to detail Screen
      else if (event is GoToDetailScreen) {
        //Transition to detail Screen
      }
      //Check if Key exists -> Go to Home Screen or Login Screen
      else if (event is CheckForLogin) {
        String token = await checkForToken();
        if (token != null) {
          jwtToken = token;

          //Later my be changet to show a nice loading screen
          List<Activity> activities = await fetchDailyActivities(jwtToken);

          List<Activity> actualActivities = getActualActivities(activities);
          double progress = getProgress(activities);
          String progressString = getProgressString(activities);
          //Then starting Loaded State with all activities

          //yield ShowLoginScreeen();
          yield MainLoaded(
              activities: activities,
              progress: progress,
              progressText: progressString,
              actualActivities: actualActivities);
        } else {
          yield (ShowLoginScreen());
        }
      }
      //Event trynign to login after usere entere credentials on login Field
      else if (event is LoginEvent) {
        log("Login Event");
        String token = await verifyUser(event.name, event.password);
        if (token != null) {
          jwtToken = token;
          List<Activity> activities = await fetchDailyActivities(jwtToken);

          List<Activity> actualActivities = getActualActivities(activities);
          double progress = getProgress(activities);
          String progressString = getProgressString(activities);
          //Then starting Loaded State with all activities

          //yield ShowLoginScreeen();
          yield MainLoaded(
              activities: activities,
              progress: progress,
              progressText: progressString,
              actualActivities: actualActivities);
        } else {
          log("Error in validation");
          yield (ShowLoginScreen());
        }
      } else if (event is LogoutEvent) {
        await logout();
        yield (ShowLoginScreen());
      }
      //Event to go to Login Screen
      else if (event is GoToLoginScreen) {
        yield ShowLoginScreen();
      }
    } catch (_) {}
  }
}

//This Function is there to check if User exists and if so writes jwt Token in shared preferences
Future<String> verifyUser(String name, String password) async {
  Map data = {'name': name, 'password': password};
  var body = json.encode(data);
  //Make auth call
  var response = await http.post('http://192.168.0.198:3000/api/auth',
      headers: {"Content-Type": "application/json"}, body: body);

  if (response.statusCode != 200) {
    log("Error doing authorization");
    return null;
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('30Day_jwtPrivateKey', response.body);
  return response.body;
}

//This function is there to return all Activities that should also be done today
List<Activity> getActualActivities(List<Activity> activities) {
  log("get actual activities");
  List<Activity> matching = new List();
  for (Activity activity in activities) {
    if (activity.fullfilled == null)
      continue;
    else {
      if (activity.fullfilled.day.compareTo(DateTime.now().day) != 0 ||
          activity.fullfilled.month.compareTo(DateTime.now().month) != 0) {
        matching.add(activity);
      }
    }
  }

  return matching;
}

//This function is there to get progress, by
double getProgress(List<Activity> activities) {
  log("get Progress");
  int fullfilled = activities.length - getActualActivities(activities).length;
  if (fullfilled == 0)
    return 0;
  else
    return fullfilled / activities.length;
}

//This Function is there to return the progress String
String getProgressString(List<Activity> activities) {
  log("Get Progress String");
  int fullfilled = activities.length - getActualActivities(activities).length;
  return "${fullfilled.toString()}/${activities.length.toString()}";
}

//Is there to check if logged in
Future<String> checkForToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //prefs.clear();
  //log("Check for token");
  //Check if token exists
  if (prefs.containsKey('30Day_jwtPrivateKey')) {
    //exist return token
    log("If");
    String token = prefs.getString('30Day_jwtPrivateKey');
    return token;
  }

  //doesnt exist -> return false,
  else {
    log("else");
    return null;
  }
}

logout() async {
  log("Logout");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
