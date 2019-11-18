import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:day_challenge/assets/api.dart';
import 'package:day_challenge/events/challengeEvents.dart';
import 'package:day_challenge/helper/challenge.dart';
import 'package:day_challenge/states/challengeStates.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BlocChallengeScreen extends Bloc<ChallengeEvents, ChallengeStates> {
  @override
  ChallengeStates get initialState => ScreenUnitialized();

  @override
  Stream<ChallengeStates> mapEventToState(ChallengeEvents event) async* {
    if (event is ShowChallengesEvent) {
      List<Challenge> challenges = await fetchAllChallenges();

      yield ShowChallenges(challenges: challenges);
    } else if (event is SubscribeToChallengeEvent) {
      // log("Subscribe to Challenge");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('30Day_jwtPrivateKey');

      //Make auth call to subscribe
      Map data = {'id': event.challenge.id};
      var body = json.encode(data);
      var response = await http.post('$webAdress/api/subscription',
          headers: {"Content-Type": "application/json", "x-auth-token": token},
          body: body);
      if (response.statusCode != 200) {
        log("Error doing authorization");
      }
    }
  }
}
