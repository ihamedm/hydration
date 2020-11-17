import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/helpers.dart';
import 'package:water_reminder/screens/dayReport/Day.dart';

class DayReport extends StatefulWidget {
  const DayReport({
    Key key,
  }) : super(key: key);

  @override
  _DayReportState createState() => _DayReportState();
}

class _DayReportState extends State<DayReport> {
  Box<Record> recordsBox;
  @override
  void initState() {
    recordsBox = Hive.box<Record>(recordsBoxName);
    super.initState();
  }

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
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  "Today Report",
                  style: Theme.of(context).textTheme.headline6.copyWith(color: PrimaryTextColor),
                ),
                SizedBox(width: 50,)
              ],
            ),
          ),
        ),
        body: ValueListenableBuilder(
          valueListenable: recordsBox.listenable(),
          builder: (BuildContext context, Box recordsBox, Widget child){
            return ListView.builder(
                itemCount: recordsBox.length,
                itemBuilder: (context , index){
                Record record = recordsBox.getAt(index);
                final DateFormat formatter = DateFormat('Hm');
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatter.format(record.time)),
                        SvgPicture.asset(
                          getCupIconSrc(record.cup),
                          height: 24,
                          width: 24,
                        ),
                        Text("${record.cup}"),
                        IconButton(
                          onPressed: (){
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              child: AlertDialog(
                                content: Text('Are you sure to delete this record?'),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text('No'),
                                      onPressed: () => Navigator.of(context).pop()
                                  ),
                                  FlatButton(
                                    child: Text('Yes'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await recordsBox.deleteAt(index);
                                    },
                                  ),
                                ],
                              )
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.grey,),
                        )
                      ],
                    ),
                  ),
                );
          });
          },
          ),
        ),
      );
  }
}
