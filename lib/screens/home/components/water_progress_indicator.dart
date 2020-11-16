import 'package:flutter/material.dart';
import 'package:water_reminder/constants.dart';

class WaterProgressIndicator extends StatefulWidget {
  final int toDrink;
  final int drinked;

  const WaterProgressIndicator({
    Key key,
    @required this.drinked,
    this.toDrink = 2000,
  }) : super(key: key);

  @override
  _WaterProgressIndicatorState createState() => _WaterProgressIndicatorState();
}

class _WaterProgressIndicatorState extends State<WaterProgressIndicator> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: 40,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey[300]),
      child: Row(
        children: [
          AnimatedContainer(
            alignment: Alignment.center,
            duration: Duration(milliseconds: 200),
            width: (widget.drinked / widget.toDrink) * screenSize.width,
            height: 40,
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200), color: PrimaryColor),
            child: Text(
              "${widget.drinked.toInt()}",
              style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
            ),
          ),
          Expanded(
              child: Text(
                (widget.toDrink - widget.drinked).toInt().toString(),
                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
                maxLines: 1,
              )
          ),
        ],
      ),
    );
  }
}
