import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  int toDrink;
  int drinked;
  final double indicatorHeight = 10;
  @override
  void initState() {
   toDrink = settings.get('to_drink', defaultValue: DefaultToDrink);
   drinked = settings.get('drinked', defaultValue: 0);

   super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: records.listenable(),
        builder: _builderWithBox
    );
  }

  Widget _builderWithBox(BuildContext context, Box records, Widget child){
    var screenSize = MediaQuery.of(context).size;
    var drinked = 0;
    List<Widget> children = [];
    for(var i = 0; i < records.length; i++){
      Record record = records.getAt(i);
      drinked += record.cup;
      if(i < records.length - 1)
      children.add(
        Positioned(
          left: ((drinked / toDrink) * screenSize.width) - 1,
          child: Container(
            width: 1,
            height: indicatorHeight,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8))
          ),
        )
      );
    }

    return Container(
      width: screenSize.width,
      height: indicatorHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[300],
      ),
      child: Row(
        children: [
          AnimatedContainer(
            alignment: Alignment.center,
            duration: Duration(milliseconds: 1000),
            width: (drinked / toDrink) * screenSize.width,
            height: indicatorHeight,
            curve: Curves.easeOut,
            decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(200), bottomLeft: Radius.circular(200)), color: PrimaryColor),
            child: Stack(children: children,),
          ),
        ],
      ),
    );
  }

}