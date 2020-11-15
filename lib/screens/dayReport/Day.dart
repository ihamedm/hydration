import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:water_reminder/constants.dart';

class Day extends StatefulWidget {
  final dynamic title;

  const Day({
    Key key,
    @required this.title
  }) : super(key: key);

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: IconColor,),
                  onPressed: (){},
                ),
                Text(
                  widget.title.toString(),
                  style: Theme.of(context).textTheme.headline6.copyWith(color: PrimaryTextColor),
                ),
                SizedBox(width: 50,)
              ],
            ),
          ),
        ),
        // body: FutureBuilder(
        //   future: Hive.openBox(''),
        // ),
      ),
    );
  }
}
