import 'package:flutter/material.dart';

class WsellerCell extends StatelessWidget {
  var wSellerArray;

  WsellerCell({this.wSellerArray});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text("name"),
            Text("phone number"),
          ],
        ),
        Row(
          children: [Text("city")],
        )
      ],
    );
  }
}
