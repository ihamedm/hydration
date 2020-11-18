import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:water_reminder/constants.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveBackground extends StatefulWidget {
  const WaveBackground({
    Key key,
  }) : super(key: key);
  @override
  _WaveBackgroundState createState() => _WaveBackgroundState();
}

class _WaveBackgroundState extends State<WaveBackground> with TickerProviderStateMixin{
  Box settings = Hive.box(settingsBoxName);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toDrink = settings.get('to_drink', defaultValue: DefaultToDrink);
    var drinked = settings.get('drinked', defaultValue: 0);
    var percentage = (toDrink - drinked ) / toDrink;
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [PrimaryColor.withOpacity(0.2), PrimaryColor.withOpacity(0.1)],
          [PrimaryColor.withOpacity(0.2), PrimaryColor.withOpacity(0.12)],
          [PrimaryColor.withOpacity(0.2), PrimaryColor.withOpacity(0.15)],
          [PrimaryColor.withOpacity(0.2), PrimaryColor.withOpacity(0.18)],
        ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: [percentage, percentage - 0.01, percentage - 0.02, percentage - 0.03],
        blur: MaskFilter.blur(BlurStyle.solid, 10),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      backgroundColor: Colors.white,
      waveAmplitude: 20,
      wavePhase: 30,
      size: Size(
        double.infinity,
        double.infinity,
      ),
    );
  }
}
