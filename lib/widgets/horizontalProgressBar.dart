//! All the important Imports
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/*
  Draws a vertical Progress Bar with rounded corners an evtl. text on the right
*/
class VerticalProgressBar extends StatefulWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final double value;
  final String text;

  const VerticalProgressBar({
    Key key,
    @required this.backgroundColor,
    this.text,
    @required this.foregroundColor,
    @required this.value,
  }) : super(key: key);

  @override
  _VerticalProgressBarState createState() {
    return _VerticalProgressBarState();
  }
}

class _VerticalProgressBarState extends State<VerticalProgressBar> {
  @override
  Widget build(BuildContext context) {
    final backgroundCOlor = widget.backgroundColor;
    final value = widget.value;
    final foregroundCOlor = widget.foregroundColor;
    final String text = widget.text;
    return Container(
        child: CustomPaint(
      child: Container(),
      foregroundPainter: VerticalProgressBarPainter(
          percentage: value,
          backgroundColor: backgroundCOlor,
          foregeoundColor: foregroundCOlor,
          text: text),
    ));
  }
}

class VerticalProgressBarPainter extends CustomPainter {
  //Filled over Constructor
  final double percentage;
  final Color backgroundColor;
  final Color foregeoundColor;
  final String text;

  //Constants
  final double borderRadius = 8;
  final Color textCol = Colors.white;
  VerticalProgressBarPainter({
    @required this.backgroundColor,
    @required this.foregeoundColor,
    @required this.percentage,
    @required this.text,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //Paint rounded Rectangle with fillig
    Offset center = size.center(Offset.zero);
    //1. Paint empty rectangle (with or without background Color if not backgorund is white)
    final backgroundPaint = Paint()
      ..color = this.backgroundColor
      ..style = PaintingStyle.fill;
    RRect background = RRect.fromLTRBR(
        0, size.height, size.width, 0, Radius.circular(borderRadius));
    canvas.drawRRect(background, backgroundPaint);
    //2 Paint another Rectangle on top with percentage;
    final foregroundPaint = Paint()
      ..color = this.foregeoundColor
      ..style = PaintingStyle.fill;

    RRect foreground = RRect.fromLTRBR(0, size.height, size.width * percentage,
        0, Radius.circular(borderRadius));
    canvas.drawRRect(foreground, foregroundPaint);

    //3. Text on the right Side
    TextSpan span = TextSpan(
        style: TextStyle(
            color: textCol, fontSize: 20, fontWeight: FontWeight.bold),
        text: text);
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    //Offset textOff = Offset(0, 0);

    Offset textOff =
        Offset(size.width - tp.width - 10, center.dy - tp.height / 2);
    tp.paint(canvas, textOff);
  }

  //!Returns whether one should Repaint
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    final oldPainter = (oldDelegate as VerticalProgressBarPainter);
    return oldPainter.foregeoundColor != this.foregeoundColor ||
        oldPainter.backgroundColor != this.backgroundColor ||
        oldPainter.percentage != this.percentage;
  }
}
