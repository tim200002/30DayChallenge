import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:day_challenge/events/detailScreenEvents.dart';
import 'package:day_challenge/events/detailScreenEvents.dart';

import 'package:day_challenge/helper/activity.dart';
import 'package:day_challenge/states/detailScreenStates.dart';
import 'package:day_challenge/states/detailScreenStates.dart';
import 'package:http/http.dart' as http;

class BLocDetailScreen extends Bloc<DetailEvents, DetailStates> {
//Function to call to change update Activity -> this means Setting the
//Date to Date.now()
  void setActivityDone(Activity activity) {
    dispatch(MakeDoneEvent(activity: activity));
  }

  void showActivity(Activity activity) {
    dispatch(ShowActivityEvent(activity: activity));
  }

  //BeginningState uninitialized Screen
  //MAybe we can directly Start with the rigth Screen doesn't get anythin from API
  @override
  DetailStates get initialState => ScreenUnitialized();

  //Map Event to State
  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is ShowActivityEvent) {
      //Just go to State where Activity is shown
      yield ShowActivity(activity: event.activity);
    }

    //Changes Activity
    else if (event is MakeDoneEvent) {
      //API Call to set Activity done and increase position by one if possible
      var res = await http.put(
          'http://192.168.0.198:3000/api/daily/${event.activity.id}',
          headers: {
            "x-auth-token":
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZGNmZDM2N2ZlZjExNTExYTg1ZjM1MzMiLCJpc0FkbWluIjp0cnVlLCJpYXQiOjE1NzM5MDE2ODd9.ILpOWKaWmch2QrIxyioiIZQKAaO4-UJtpj_3V1bfd-c"
          });
      log(res.body.toString());
      //new State where one can only See the Activity no option to make active
      // yield ActvityActive(activity: activity);
      yield ActivityDone(activity: event.activity);
    }
  }
}
