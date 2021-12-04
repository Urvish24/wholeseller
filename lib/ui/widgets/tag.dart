import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  bool IsActive;

  Tag(this.IsActive);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(
              width: 1.0,
              color: appSecondColor
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //                 <--- border radius here
          ),
        ),
        child: Text(IsActive?"Active":"Inactive",style: list_normal,));
  }
}
