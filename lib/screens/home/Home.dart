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
import 'package:water_reminder/screens/home/components/water_progress_indicator2.dart';
import 'package:water_reminder/screens/home/components/wave_background.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now = new DateTime.now();
  String todayString = DateFormat.MMMMEEEEd().format(DateTime.now());
  Box<Record> recordsBox;
  int drinked;

  @override
  void initState() {
    super.initState();
    recordsBox = Hive.box<Record>(recordsBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(settingsBoxName).listenable(),
        builder: _builderWithBox
    );
  }


  Widget _builderWithBox(BuildContext context, Box settingsBoxName, Widget child){
    var selectedCup = settingsBoxName.get('selected_cup', defaultValue: DefaultCupSize);
    var selectedCupIconSrc = getCupIconSrc(selectedCup);
    var drinked = settingsBoxName.get('drinked', defaultValue: 0);

    return Stack(
      children: [
        WaveBackground(),
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
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => DayReport())
                      );
                    },
                    child: Container(
                      color: Colors.grey[300],
                      child: WaterProgressIndicator()
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "drink normal water instead of cold water!",
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: FlatButton(
                    onPressed: (){
                      settingsBoxName.put('drinked', drinked + selectedCup);
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
                        settingsBoxName.put('drinked', 0);
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