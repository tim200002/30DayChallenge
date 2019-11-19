import 'dart:developer';

import 'package:day_challenge/assets/art.dart';
import 'package:day_challenge/assets/colors.dart';
import 'package:day_challenge/blocs/blocChallengeScree.dart';
import 'package:day_challenge/events/MainScreenEvents.dart';
import 'package:day_challenge/helper/activity.dart';
import 'package:day_challenge/screens/LoadingScreen.dart';
import 'package:day_challenge/screens/challengeScreen.dart';
import 'package:day_challenge/screens/login2.dart';
import 'package:day_challenge/screens/loginOrRegister.dart';
import 'package:day_challenge/states/MainScreenStates.dart';
import 'package:day_challenge/blocs/BlocMainScreen.dart';
import 'package:day_challenge/widgets/blockWidgets.dart';
import 'package:day_challenge/widgets/statefullPorgressCircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  final double firstContainerHeight = 40; //Height of first Container
  //final blocHomeScreen = new BlocHomeScreen();

  //Dispose Bloc to prevent Memeory Leak
  /* @override
  void dispose() {
    blocHomeScreen.();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    //Refresh Function
    Future<Null> _handleRefresh() async {
      BlocProvider.of<BlocHomeScreen>(context).add(FetchAll());
    }

    //Navigate Functions
    _navigateToChallengeScreen(List<Activity> activities) async {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider<BlocChallengeScreen>(
                builder: (BuildContext context) =>
                    BlocChallengeScreen(activities: activities),
                child: ChallengeScreen());
          },
        ),
      );
      if (result == true) {
        log("update the Screen");
        BlocProvider.of<BlocHomeScreen>(context).add(FetchAll());
      }
    }

    //Allert Box
    Alert logoutAlert = new Alert(
      context: context,
      type: AlertType.warning,
      title: "Logout",
      desc: "Do you really want to Logout",
      buttons: [
        DialogButton(
          child: Text(
            "NOPE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.green,
        ),
        DialogButton(
          child: Text(
            "LOGOUT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            BlocProvider.of<BlocHomeScreen>(context).add(LogoutEvent());
          },
          color: Colors.red,
        ),
      ],
    );

    //This is just for testing purposes, later must be st with Bloc:
    //const progress = 0.8;
    //Get Color of progress Indicator
    //Color foregroundColor = progressColor(progress);
    return Scaffold(
      body: BlocBuilder<BlocHomeScreen, MainScreenState>(
        builder: (context, state) {
          //While checking if logged in and getting Data
          if (state is MainUninitialized) {
            BlocProvider.of<BlocHomeScreen>(context)
                .add(CheckForLogin()); //! This was changed
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
          //When State is Show Login screen -> show Login Screen
          else if (state is ShowLoginScreen) {
            log("state");
            return LoginScreen();
          }

          //Display all Activities on the Main Screen -> normaly all the Time
          else if (state is MainLoaded) {
            log("Hello");
            return SafeArea(
                child: Column(
              children: <Widget>[
                //This is for the small top UI-Elements
                //Container is just for using defined Size
                //Maybe I find a better Way to use flex
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        child: GestureDetector(
                            child: Icon(
                              Icons.block,
                              color: Colors.white,
                              size: firstContainerHeight,
                            ),
                            onTap: () => logoutAlert.show()),
                        padding: const EdgeInsets.all(12.0),
                      ),
                      Padding(
                        child: GestureDetector(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: firstContainerHeight,
                          ),
                          onTap: () {
                            log("Plus tapped");
                            /*Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return BlocProvider<BlocChallengeScreen>(
                                      builder: (BuildContext context) =>
                                          BlocChallengeScreen(),
                                      child: ChallengeScreen());
                                },
                              ),
                            );*/
                            _navigateToChallengeScreen(state.activities);
                          },
                        ),
                        padding: const EdgeInsets.all(12.0),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  height: firstContainerHeight, //This hardcoded isn't so nice
                ),
                Expanded(
                  child: Container(
                    child: CircleProgressBar(
                        foregroundColor:
                            progressColor(getProgress(state.activities)),
                        value: getProgress(state.activities),
                        backgroundColor: Colors.black,
                        text:
                            state.progressText //This text must be set with Bloc
                        ),
                    height: 100, //This isn't so nice maybe later with flex
                    width: double.infinity,
                  ),
                  flex: 1, //Why is there a flex here
                ),
                Expanded(
                  //Later Refresh should be added
                  child: RefreshIndicator(
                    child: ListView.builder(
                      itemCount: state.actualActivities.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BlockTile(
                            activity: state.actualActivities[index],
                            icon: iconAndroid,
                            backgroundColor: darkBlue);
                      },
                    ),
                    onRefresh: () => _handleRefresh(),
                  ),
                  flex: 4,
                ),
              ],
            ));
          } else if (state is LoginOrRegister) {
            return LoginOrRegisterScreen();
          } else if (state is Loading) {
            return LoadingScreen();
          }
        },
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}

//This function decides the Color for the progress Indicator
Color progressColor(double progress) {
  if (progress >= 0.8)
    return Colors.green;
  else
    return Colors.red;
}
