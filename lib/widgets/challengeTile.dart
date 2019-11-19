import 'package:day_challenge/assets/style.dart';
import 'package:day_challenge/blocs/blocChallengeScree.dart';
import 'package:day_challenge/events/challengeEvents.dart';
import 'package:day_challenge/helper/challenge.dart';
import 'package:day_challenge/helper/hexColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ChallengeTile extends StatefulWidget {
  final Challenge challenge;

  //Constructor
  ChallengeTile({@required this.challenge, key}) : super(key: key);

  @override
  _ChallengeTileState createState() => _ChallengeTileState();
}

class _ChallengeTileState extends State<ChallengeTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(10)),
              color: HexColor(widget.challenge.color),
            ),
            //Screen Properties
            width: double.infinity,
            height: 250,

            //! Here is where the design starts
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Image
                Expanded(
                  child: Padding(
                    child: Image.asset(
                      widget.challenge.image,
                      fit: BoxFit.fill,
                    ),
                    padding: EdgeInsets.only(left: 7.0),
                  ),
                  //FittedBox(fit: BoxFit.fill, child: widget.icon),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 20.0, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            widget.challenge.name,
                            style: blockHeading,
                          ),
                        ),
                        Text(widget.challenge.description,
                            style: challengeSmall)
                      ],
                    ),
                  ),
                  flex: 2,
                )
              ],
            ),
          ),
        ),
        onTap: () {
          Alert(
              context: context,
              type: AlertType.info,
              title: "Challenge",
              desc: "Do you want to try out this Challenge",
              buttons: [
                DialogButton(
                  child: Text(
                    "Let's Do It",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    BlocProvider.of<BlocChallengeScreen>(context).add(
                        SubscribeToChallengeEvent(challenge: widget.challenge));
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  },
                )
              ]).show();
        });
  }
}
