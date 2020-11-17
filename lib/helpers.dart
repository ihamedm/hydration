import 'package:water_reminder/constants.dart';

void printWidgetName(widget){
  print('build ${widget.toString()}');
}

String getCupIconSrc(int iconSize){
  String cupIconSvgFile;

  for(var cup in cups){
    if(cup['value'] == iconSize){
      cupIconSvgFile = cup['iconSvgFile'];
    }
  }

  return "assets/icons/$cupIconSvgFile";
}