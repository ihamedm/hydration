import 'package:hive/hive.dart';
part 'Day.g.dart';


@HiveType(typeId: 1)
class Day{
  @HiveField(0)
  DateTime day;
  @HiveField(1)
  int counter;
  @HiveField(2)
  int total;
  @HiveField(3)
  bool done;

  Day(this.day, this.counter, this.total, this.done);
}

@HiveType(typeId: 2)
class Record{
  @HiveField(0)
  DateTime time;
  @HiveField(1)
  int cup;

  Record(this.time, this.cup);
}