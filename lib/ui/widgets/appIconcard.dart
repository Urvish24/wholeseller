import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

class appIconcard extends StatelessWidget {
  IconData iconData;
  appIconcard({this.iconData});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(17.0),
        ),child: Container(
        height: 30,width: 30,
        child: Icon(iconData,color: appSecondColor,size: 20)));
  }
}
