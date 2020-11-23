import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/helpers.dart';
import 'package:water_reminder/screens/dayReport/Day.dart';
import 'package:water_reminder/screens/dayReport/DayReport.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/screens/home/components/cup_items_list.dart';
import 'package:water_reminder/screens/home/components/progress_path.dart';
import 'package:water_reminder/screens/home/components/wave_background.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  DateTime now = new DateTime.now();
  String todayString = DateFormat.MMMMEEEEd().format(DateTime.now());
  Box<Record> recordsBox;
  Box settingBox;

  double _screenHeight;
  double _screenWidth;
  int drinked;
  int toDrink;

  double percentValue;
  double newPercentValue;

  @override
  void initState() {
    super.initState();
    recordsBox = Hive.box<Record>(recordsBoxName);
    settingBox = Hive.box(settingsBoxName);
    toDrink = settingBox.get('to_drinked', defaultValue: DefaultToDrink);
    drinked = settingBox.get('drinked', defaultValue: 0);
    percentValue = drinked / toDrink;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: settingBox.listenable(),
        builder: _builderWithBox
    );
  }


  Widget _builderWithBox(BuildContext context, Box settingBox, Widget child){
    // Hive box data
    var selectedCup = settingBox.get('selected_cup', defaultValue: DefaultCupSize);
    var selectedCupIconSrc = getCupIconSrc(selectedCup);
    drinked = settingBox.get('drinked', defaultValue: 0);

    // global data
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        WaveBackground(percentage: percentValue,),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.pie_chart, color: IconColor,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Icons.settings, color: IconColor,),
                      onPressed: (){},
                    )
                  ],
                ),
              ),
            ),

            body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$todayString', style: Theme.of(context).textTheme.headline6.copyWith(color: SecondaryTextColor),),
                SizedBox(height: 10,),
                Text("Today Drinks", style: Theme.of(context).textTheme.headline1.copyWith(color: PrimaryTextColor),),
                SizedBox(height: 20,),
                Container(
                  width: _screenWidth,
                  height: _screenHeight/3,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => DayReport())
                      );
                    },
                    child: ProgressIndicatorWidget(percentage: percentValue,)
                  )
                ),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        newPercentValue = (drinked + selectedCup)/toDrink;
                        // TODO: this value can change by value animating
                        percentValue = newPercentValue;
                      });
                      settingBox.put('drinked', drinked + selectedCup);
                      recordsBox.add(Record(new DateTime.now(),selectedCup));
                    },
                    onLongPress: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext bc) {
                            return CupItemsList();
                          }
                      );
                    },
                    color: PrimaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200)) ,
                    ),
                    child:
                    SvgPicture.asset(selectedCupIconSrc, color: Colors.white, height: 48, width: 48,)
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        settingBox.put('drinked', 0);
                        percentValue = 0;
                        recordsBox.clear();
                      });
                    },
                    child: Text(
                      "Hold to change cup",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),

              ],
            ),
          ),
          ),
        ),
      ]
    );

  }


}