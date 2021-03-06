import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:day_challenge/assets/api.dart';
import 'package:day_challenge/events/detailScreenEvents.dart';
import 'package:day_challenge/states/detailScreenStates.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BLocDetailScreen extends Bloc<DetailEvents, DetailStates> {

  //BeginningState uninitialized Screen
  //?Maybe we can directly Start with the rigth Screen doesn't get anything from API
  @override
  DetailStates get initialState => ScreenUnitialized();

  //Map Event to State
  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is ShowActivityEvent) {
      log("Show Activity Events");
      log(event.activity.description);
      //Just go to State where Activity is shown
      yield ShowActivity(activity: event.activity);
    }

    //Changes Activity
    else if (event is MakeDoneEvent) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('30Day_jwtPrivateKey');
      //API Call to set Activity done and increase position by one if possible
      var res = await http.put('$webAdress/api/daily/${event.activity.id}',
          headers: {"x-auth-token": token});
      log(res.body.toString());
      //new State where one can only See the Activity no option to make active
      // yield ActvityActive(activity: activity);
      yield ActivityDone(activity: event.activity);
    }
  }
}
