import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/screens/dayReport/Day.dart';
import 'components/cup_items_list.dart';
import 'components/water_progress_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/wave_background.dart';
import 'package:hive/hive.dart';

class Home extends StatefulWidget {
  final Box appSettings;

  const Home({Key key, @required this.appSettings}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences prefs;
  int selectedCup;
  String selectedCupIcon;
  double drinked;

  DateTime now = new DateTime.now();
  String todayString = DateFormat.MMMMEEEEd().format(DateTime.now());

  @override
  void initState() {
    super.initState();

    this.drinked = 0;
    getPrefs();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    selectedCup = prefs.getInt('selected_cup') ?? CupDefaultSize;
    selectedCupIcon = prefs.getString('selected_cup_icon') ?? CupDefaultIcon;

    return Stack(
      children: [
        WaveBackground(drinked: drinked),
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
                          MaterialPageRoute(builder: (context) => Day(title: todayString))
                      );
                    },
                    child: WaterProgressIndicator(drinked: drinked,)
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
                      setState(() {
                        drinked += selectedCup;
                      });
                    },
                    onLongPress: (){
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext bc) {
                            return CupItemsList(prefs: prefs, notifyParent: refresh);
                          }
                      );
                    },
                    color: PrimaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(200)) ,
                    ),
                    child:
                    SvgPicture.asset("assets/icons/$selectedCupIcon", color: Colors.white, height: 48, width: 48,)
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onLongPress: (){
                      setState(() {
                        drinked = 0;
                      });
                    },
                    child: Text(
                      "Hold to change cup",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),
          ),
        ),
      ]
    );
  }


  Future getPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(!prefs.containsKey('selected_cup')){
    //   await prefs.setInt('selected_cup', 100).then(
    //           (value) {
    //             setState(){
    //               this.prefs = prefs;
    //             }
    //           }
    //   );
    // }
    setState(() {
      this.prefs = prefs;
    });
  }
}

