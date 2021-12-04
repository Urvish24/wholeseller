import 'dart:ffi';

import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/CustomerDetailAction.dart';
import 'package:bwc/ui/pages/ItemDetail.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/appIconcard.dart';
import 'package:bwc/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class ItemsCell extends StatelessWidget {
  var wSellerArray;
  int i;
  var model;

  ItemsCell({this.wSellerArray,this.i,this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ItemDetail(data : wSellerArray);
      })),
      child: Card(
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              (wSellerArray.itmImageName != "")?
              SizedBox(width: 90,height: 120):
              //Image.network(wSellerArray.itmImageName,width: 90,height: 120,fit: BoxFit.fill,):
              SizedBox(width: 90,height: 120),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(wSellerArray.itmName,style: list_titleblack,overflow: TextOverflow.visible,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("₹"+wSellerArray.itmPrice.toString(),style: TextStyle(color: appSecondColor,fontWeight: FontWeight.w500)),
                              Padding(
                                padding: const EdgeInsets.only(right:10.0),
                                child: Text("Pack Of : "+wSellerArray.itmNoOfPack.toString(),style: TextStyle(color: appSecondColor,fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(color: appSecondColor,width: 1,height: 60,),
                        SizedBox(width: 10,),
                        GestureDetector(
                            onTap: ()=>model.deleteServerItem(wSellerArray.sId,context),
                            child: appIcon(iconData : Icons.delete)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],),
        ),
      ),
    );
  }
}
