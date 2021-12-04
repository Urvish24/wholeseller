import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

class appIcon extends StatelessWidget {
  IconData iconData;
  appIcon({this.iconData});

  @override
  Widget build(BuildContext context) {
    return Icon(iconData,color: appSecondColor,size: 30);
  }
}
