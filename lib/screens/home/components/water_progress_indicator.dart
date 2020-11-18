import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/screens/dayReport/Day.dart';

class WaterProgressIndicator extends StatefulWidget {
  const WaterProgressIndicator({
    Key key,
  }) : super(key: key);

  @override
  _WaterProgressIndicatorState createState() => _WaterProgressIndicatorState();
}

class _WaterProgressIndicatorState extends State<WaterProgressIndicator> with TickerProviderStateMixin {
  Box settings = Hive.box(settingsBoxName);
  Box<Record> records = Hive.box<Record>(recordsBoxName);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var toDrink = settings.get('to_drink', defaultValue: DefaultToDrink);
    var drinked = settings.get('drinked', defaultValue: 0);

    return Container(
      width: screenSize.width,
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey[300]),
      child: Row(
        children: [
          AnimatedContainer(
            alignment: Alignment.center,
            duration: Duration(milliseconds: 200),
            width: (drinked / toDrink) * screenSize.width,
            height: 40,
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: PrimaryColor),
            child: Text(
              "${drinked.toInt()}",
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
              child: Text(
                (toDrink - drinked).toInt().toString(),
                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                maxLines: 1,
              )
          ),
        ],
      ),
    );

  }
}
