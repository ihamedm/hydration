import 'package:flutter/material.dart';

const settingsBoxName = 'settings';

const PrimaryColor = Color(0xFF0089FF);
const IconColor = Color(0xFFACACAC);
const CupIconColor = Color(0xFF434343);
const SelectedCupIconColor = Color(0xFF0089FF);
const PrimaryTextColor = Color(0xFF434343);
const SecondaryTextColor = Color(0xFFA3C4E1);


// Cup data
const List cups = [
  {"value": 100, "label": "100 ml", "iconSvgFile": "cup.svg",},
  {"value": 150, "label": "150 ml", "iconSvgFile": "espresso.svg",},
  {"value": 180, "label": "180 ml", "iconSvgFile": "coffee.svg",},
  {"value": 200, "label": "200 ml", "iconSvgFile": "glass.svg",},
  {"value": 250, "label": "250 ml", "iconSvgFile": "milk-bottle.svg",},
  {"value": 300, "label": "300 ml", "iconSvgFile": "water-bottle.svg",},
];
const CupDefaultSize = 100;
const CupDefaultIcon = "cup.svg";