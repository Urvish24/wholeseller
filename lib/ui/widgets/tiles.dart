import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {

  String name,value;


  Tiles({this.name, this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        color: appColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(value,style: TextStyle(color: Colors.white),),
            Text(name,style: TextStyle(color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
