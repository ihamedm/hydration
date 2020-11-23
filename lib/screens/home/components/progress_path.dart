import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/helpers.dart';
import 'package:water_reminder/screens/dayReport/Day.dart';

class ProgressIndicatorWidget extends StatefulWidget {

  final double percentage;

  const ProgressIndicatorWidget({
    Key key, @required this.percentage,
  }) : super(key: key);

  @override
  _ProgressIndicatorWidgetState createState() => _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  // Box settings = Hive.box(settingsBoxName);
  // Box<Record> records = Hive.box<Record>(recordsBoxName);
  // TODO add record lines to path
  @override
  void initState() {
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ProgressPainter(
          percentage: widget.percentage
      ),
      child: Text("${widget.percentage}"),
    );
  }

}

// Painter
class ProgressPainter extends CustomPainter{
  double percentage;

  ProgressPainter({this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = new Paint()
      ..color = Colors.grey[300]
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;


    Paint completePaint = new Paint()
      ..color = PrimaryColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width, size.height);

    Rect progressRect = Rect.fromCenter(center: center , width: radius, height: radius);

    Path bgPath = Path()
      ..arcTo(
          progressRect,
          pi * 3/4,
          pi * 3/2,
          false
      );

    Path completePath = Path()
    ..arcTo(
        progressRect,
        pi * 3/4,
        pi * 3/4 * percentage,
        false
    );

    canvas.drawPath(bgPath, bgPaint);
    canvas.drawPath(completePath, completePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}