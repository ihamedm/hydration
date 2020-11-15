import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/screens/home/Home.dart';

void main() async{
  await Hive.initFlutter();
  runApp(WaterDrinkReminderApp());
}

class WaterDrinkReminderApp extends StatelessWidget {
  final settings = Hive.openBox(settingsBoxName);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Water drinking reminder",
      home: Home(),
      theme: ThemeData(
        textTheme: TextTheme(
            headline1: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
      )
    );
  }

}
