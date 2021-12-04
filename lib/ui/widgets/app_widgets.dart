import 'package:bwc/constant/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// build Loading
Widget buildLoadingUi() {
  return Center(child: CircularProgressIndicator( valueColor: new AlwaysStoppedAnimation<Color>(appColor),));
}

// build Error UI
Widget buildErrorUi(String message) {
  return Center(
    child: Text(
      message,
      style: TextStyle(color: Colors.red),
    ),
  );
}

Widget smallImg(String route) {
  return Container(margin:EdgeInsets.only(right: 5),child: Image.asset(route,width: 15,height: 15,color: appColor,));
}