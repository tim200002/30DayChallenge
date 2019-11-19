import 'package:day_challenge/assets/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MakeDoneScreen extends StatelessWidget {
  const MakeDoneScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: FractionalOffset.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
            child: Text(
              "Congratulation you made it today, here's a coockie for you",
              style: secondBigStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(
                  'images/cookie1.png',
                  fit: BoxFit.fill,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
