import 'package:day_challenge/assets/colors.dart';
import 'package:day_challenge/blocs/blocChallengeScree.dart';
import 'package:day_challenge/events/challengeEvents.dart';
import 'package:day_challenge/states/challengeStates.dart';
import 'package:day_challenge/widgets/challengeTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChallengeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlocChallengeScreen, ChallengeStates>(
        builder: (context, state) {
          //While loading Challenges
          if (state is ScreenUnitialized) {
            BlocProvider.of<BlocChallengeScreen>(context)
                .add(ShowChallengesEvent());
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Waiting to connect to the Internet",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            );
          }

          //Showing the Challenges
          if (state is ShowChallenges) {
            return SafeArea(
                child: Column(
              children: <Widget>[
                Container(
                  child: Text("Select a Challenge",
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                  padding: EdgeInsets.all(15),
                ),
                //List of Tiles
                Expanded(
                    child: ListView.builder(
                  itemCount: state.challenges.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ChallengeTile(challenge: state.challenges[index]);
                  },
                ))
              ],
            ));
          }
        },
      ),
      backgroundColor: backgroundGrey,
    );
  }
}
