import 'package:day_challenge/assets/colors.dart';
import 'package:day_challenge/assets/style.dart';
import 'package:day_challenge/blocs/blocDetailScreen.dart';
import 'package:day_challenge/events/detailScreenEvents.dart';
import 'package:day_challenge/helper/activity.dart';
import 'package:day_challenge/states/detailScreenStates.dart';
import 'package:day_challenge/widgets/makeDoneScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({@required this.activity, Key key}) : super(key: key);

  final Activity activity;
  final double topBarHeight = 30;
  final double checkImageSize = 70;
  //final detailBloc = new BLocDetailScreen();

  //final detailBloc=new BlocDetailScreen()
/*
  @override
  void dispose() {
    detailBloc.sink();
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BLocDetailScreen, DetailStates>(
        builder: (context, state) {
          if (state is ScreenUnitialized) {
            BlocProvider.of<BLocDetailScreen>(context)
                .add(ShowActivityEvent(activity: activity));
            return SafeArea(
              child: Text("Error uninitialized"),
            );
          } else if (state is ShowActivity) {
            return SafeArea(
              child: Column(
                //Alles von Haus aus linksbündig
                crossAxisAlignment: CrossAxisAlignment.start,

                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: topBarHeight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              size: topBarHeight,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, right: 8),
                          child: Text(
                            "Day ${state.activity.position} of ${state.activity.length}",
                            //! To Do make asset or Variable dont hardcode also in next
                            style: secondBigStyle,
                            //Optional I belive
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 20, right: 8),
                          child: Text(
                            "${state.activity.description}",
                            //!To DO make asset or Variabke dont hard code
                            style: secondBigStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: GestureDetector(
                            child: Image.asset(
                              'images/checkedVar2.png',
                              width: checkImageSize,
                              height: checkImageSize,
                            ),
                            onTap: () =>
                                BlocProvider.of<BLocDetailScreen>(context)
                                    .add(MakeDoneEvent(activity: activity)),
                          ),
                        )),
                  )
                ],
              ),
            );
          } else if (state is ActivityDone) {
            return MakeDoneScreen();
          }
        },
      ),
      backgroundColor: backgroundGrey,
    );
  }
}
