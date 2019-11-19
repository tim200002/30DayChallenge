import 'package:day_challenge/helper/challenge.dart';
import 'package:flutter/foundation.dart';

abstract class ChallengeStates {}

//State, if Scree is uninitialized while Loading Challenges
class ScreenUnitialized extends ChallengeStates {
  @override
  String toString() => 'ScreenUninitalized';
}

//State when Challanges loades
class ShowChallenges extends ChallengeStates {
  final List<Challenge> challenges;
  ShowChallenges({@required this.challenges});

  @override
  String toString() => "Show Challenges";
}

class SubscribeToChallenge extends ChallengeStates {
  @override
  String toString() => 'SubscribeToChallenge';
}
