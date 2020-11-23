import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/screens/dayReport/Day.dart';
import 'package:water_reminder/screens/generals/errorFullScreen.dart';
import 'package:water_reminder/screens/generals/loadingFullScreen.dart';
import 'package:water_reminder/screens/home/Home.dart';
import 'package:water_reminder/themes.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(RecordAdapter());
  runApp(WaterDrinkReminderApp());
}

class WaterDrinkReminderApp extends StatelessWidget {
  final settings = Hive.openBox(settingsBoxName);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: themeData,
      home: FutureBuilder(
        future: Future.wait([
          Hive.openBox(settingsBoxName),
          Hive.openBox<Record>(recordsBoxName),
        ]),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.error != null){
              print(snapshot.error);
              return ErrorFullScreen();
            }else{
              return Home();
            }
          }else{
            return LoadingFullScreen();
          }
        }
      )
    );
  }

}
