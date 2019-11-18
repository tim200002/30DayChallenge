import 'package:day_challenge/helper/challenge.dart';
import 'package:day_challenge/states/challengeStates.dart';
import 'package:flutter/material.dart';

abstract class ChallengeEvents {}

//Event to Load Screen and show all challenges
class ShowChallengesEvent extends ChallengeEvents {}

//Event to Subscribe to Challenge
class SubscribeToChallengeEvent extends ChallengeEvents {
  Challenge challenge;
  SubscribeToChallengeEvent({@required this.challenge});
}
