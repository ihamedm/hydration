import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:water_reminder/constants.dart';
import 'package:water_reminder/helpers.dart';

import 'cup_items_list.dart';

class CupItem extends StatefulWidget {
  final bool isActive;
  final String iconSrc;
  final Color activeColor;
  final String label;
  final int value;
  final VoidCallback onTapCallback;

  const CupItem(
      {Key key,
      this.iconSrc,
      this.label,
      this.value,
      this.onTapCallback,
      this.activeColor, this.isActive})
      : super(key: key);

  @override
  _CupItemState createState() => _CupItemState();
}

class _CupItemState extends State<CupItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTapCallback();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.isActive ?  PrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
          SvgPicture.asset(
            widget.iconSrc,
            color: widget.isActive ? Colors.white : CupIconColor,
            height: 48,
            width: 48,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.label,
            style: TextStyle(color: widget.isActive ? Colors.white : CupIconColor, fontWeight: FontWeight.w700),
          )
        ]),
      ),
    );
  }
}
