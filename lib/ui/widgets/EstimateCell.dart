import 'dart:ffi';

import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/appIconcard.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class EstimateCell extends StatelessWidget {
  var wSellerArray;
  int i;

  EstimateCell({this.wSellerArray,this.i});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text("#${i+1}",style: list_title,),
              Text("\$1024",style: list_title,),
            ],),
            sizedBoxUv,
            Container(height: 2,color: appSecondColor,),
            sizedBoxUv,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Customer Name",style: list_titleblack,),
                Text("03-Jul-21",style: list_normal,),
              ],
            ),
            sizedBoxlightUv,
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      appIconcard(iconData:Icons.featured_play_list_outlined),
                      appIconcard(iconData:Icons.money),
                  ],),
                ),
                Expanded(child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: OutlinedButton(onPressed: ()=>{},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide( color: appSecondColor),
                      ),
                      child: Text("Accept",style: list_normal),
                    ),

                )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
