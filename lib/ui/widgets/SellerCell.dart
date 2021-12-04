import 'dart:ffi';

import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/CustomerDetailAction.dart';
import 'package:bwc/ui/pages/SellerDetailAction.dart';
import 'package:bwc/ui/widgets/WsellerCell.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/appIconcard.dart';
import 'package:bwc/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class SellerCell extends StatelessWidget {
  var wSellerArray;
  int i;

  SellerCell({this.wSellerArray,this.i});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return SellerDetailAction(wSellerArray);
      })),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(wSellerArray['usr_name'],style: list_title,),
                     // Text(wSellerArray.usrCity,style: list_titleblack),
                    ],),
                    sizedBoxUv,
                    Container(height: 1,color: appSecondColor,),
                    sizedBoxUv,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wSellerArray.containsKey("usr_email")?
                        Text(wSellerArray['usr_email'],style: list_titleblack):
                        Text("Not provided",style: list_titleblack),
                        Text(wSellerArray['usr_phone_number'],style: list_normal,),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  Container(color: appSecondColor,width: 1,height: 60,),
                  SizedBox(width: 10,),
                  GestureDetector(
                      //onTap: ()=>model.deleteServerItem(wSellerArray.sId),
                      child: appIcon(iconData : Icons.keyboard_arrow_right_rounded)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
