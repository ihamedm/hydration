import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/helpers.dart';
import 'cup_item.dart';

class CupItemsList extends StatefulWidget {
  const CupItemsList({
    Key key,
  }) : super(key: key);

  @override
  _CupItemsListState createState() => _CupItemsListState();
}

class _CupItemsListState extends State<CupItemsList> {
  Box settings;

  @override
  void initState() {
    super.initState();
    settings = Hive.box(settingsBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ValueListenableBuilder(
        valueListenable: settings.listenable(),
        builder: _builderWithBox
      )
    );
  }


  Widget _builderWithBox(BuildContext context, Box settings, Widget child){
    var selectedCupSize = settings.get('selected_cup', defaultValue: DefaultCupSize);
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.all((Radius.circular(30))),color: Colors.white),
      child: GridView.builder(
        itemCount: cups.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CupItem(
            iconSrc: getCupIconSrc(cups[index]["value"]),
            isActive: selectedCupSize == cups[index]["value"],
            label: cups[index]["label"],
            value: cups[index]["value"],
            onTapCallback: () {
              settings.put('selected_cup', cups[index]["value"]);
              Future.delayed(Duration(milliseconds: 300), (){
                Navigator.of(context).pop();
              });
            },
          );
        },
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ),
    );

  }
}
