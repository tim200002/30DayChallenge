import 'package:day_challenge/assets/style.dart';
import 'package:day_challenge/blocProvider/detailProvider.dart';
import 'package:day_challenge/blocs/BlocMainScreen.dart';
import 'package:day_challenge/blocs/blocDetailScreen.dart';
import 'package:day_challenge/events/MainScreenEvents.dart';
import 'package:day_challenge/helper/activity.dart';
import 'package:day_challenge/helper/hexColor.dart';
import 'package:day_challenge/screens/detailScreen2.dart';

import 'package:day_challenge/widgets/horizontalProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
  Widget for one Bloc of an Activity on the Main Screen
*/

class BlockTile extends StatefulWidget {
  //variables for this class
  Activity activity;
  Icon icon;
  Color backgroundColor;
  //Constructor
  BlockTile(
      {@required this.activity,
      @required this.backgroundColor,
      @required this.icon,
      key})
      : super(key: key);

  @override
  _BlockTileState createState() => _BlockTileState();
}

class _BlockTileState extends State<BlockTile> {
  _BlockTileState();
  @override
  Widget build(BuildContext context) {
    //Navigation Function
    _navigateToDetailScreen() async {
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return BlocProvider<BLocDetailScreen>(
                builder: (BuildContext context) => BLocDetailScreen(),
                child: DetailScreen(activity: widget.activity));
          },
        ),
      );

      if (true) {
        BlocProvider.of<BlocHomeScreen>(context).add((FetchAll()));
      }
    }

    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            //Decoration of the Tile
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(const Radius.circular(10)),
              color: HexColor(widget.activity.color),
            ),
            //Screen Properties
            width: double.infinity, //expands whole screen except padding
            height: 170, //evtl. dynamic

            //! Here is where the Design starts
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //Widget for Challenge
                  Expanded(
                    child: Padding(
                      child: Image.asset(
                        widget.activity.image,
                        fit: BoxFit.fill,
                      ),
                      padding: EdgeInsets.only(left: 7.0),
                    ),
                    //FittedBox(fit: BoxFit.fill, child: widget.icon),
                    flex: 1,
                  ),
                  Expanded(
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //Headline
                          Text(
                            widget.activity
                                .name, //Passing Argument from Construcor
                            style: blockHeading,
                          ),
                          //horizontal Progress Bar
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  //color: Colors.orange,
                                  borderRadius: BorderRadius.all(
                                      const Radius.circular(7)),
                                ),
                                child: VerticalProgressBar(
                                    text:
                                        "${widget.activity.position + 1}/${widget.activity.length}",
                                    backgroundColor: Colors.grey[500],
                                    foregroundColor: Colors.red,
                                    value: widget.activity.position /
                                        (widget.activity.length - 1))),
                          ),
                        ],
                      ),
                    )),
                    flex: 3,
                  ),
                ]),
          ),
        ),
        onTap: () => {
              /*Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return BlocProvider<BLocDetailScreen>(
                        builder: (BuildContext context) => BLocDetailScreen(),
                        child: DetailScreen(activity: widget.activity));
                  },
                ),
              ),*/
              _navigateToDetailScreen()
            });
  }
}
