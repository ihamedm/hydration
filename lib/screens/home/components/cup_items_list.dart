import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/helpers.dart';
import 'cup_item.dart';

// @todo bring selected cup to first
// @todo handle Exceptions

class CupItemsList extends StatefulWidget {
  final SharedPreferences prefs;
  final Function notifyParent;

  const CupItemsList({
    Key key,
    @required this.notifyParent, this.prefs,
  }) : super(key: key);

  @override
  _CupItemsListState createState() => _CupItemsListState();
}

class _CupItemsListState extends State<CupItemsList> {
  int selectedCupSize;
  String selectedCupIcon;


  @override
  void initState() {
    super.initState();
    selectedCupSize = widget.prefs.getInt('selected_cup') ?? CupDefaultSize;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all((Radius.circular(30))),color: Colors.white),
          child: cupListGridView(),
        )
    );
  }


  cupListGridView<Widget>(){
    return GridView.builder(
      itemCount: cups.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CupItem(
            iconSrc: "assets/icons/${cups[index]["iconSvgFile"]}",
            isActive: selectedCupSize == cups[index]["value"],
            label: cups[index]["label"],
            value: cups[index]["value"],
            onTapCallback: () {
              saveSelectedCup([cups[index]["value"], cups[index]["iconSvgFile"]]).whenComplete(
                (){
                    widget.notifyParent();
                    Future.delayed(Duration(milliseconds: 300), (){
                      Navigator.of(context).pop();
                    });
                  }
              );
            },
          );
        },
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    );

  }

  Future saveSelectedCup(List<dynamic> selectedCup) async {
    await widget.prefs
        .setInt('selected_cup', selectedCup[0])
        .whenComplete(() => print('prefs saved!'));

    await widget.prefs.setString('selected_cup_icon', selectedCup[1]);


    setState(() {
      this.selectedCupSize = selectedCup[0];
    });
  }
}
