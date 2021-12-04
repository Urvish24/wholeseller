import 'dart:ffi';

import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/CustomerDetailAction.dart';
import 'package:bwc/ui/pages/ItemDetail.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/appIconcard.dart';
import 'package:bwc/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class EstimateItemsCell extends StatefulWidget {
  var wSellerArray;
  int i;
  var model;
  GestureTapCallback onTap;
  Function counting;

  EstimateItemsCell({this.wSellerArray,this.i,this.model,this.onTap,this.counting});

  @override
  _EstimateItemsCellState createState() => _EstimateItemsCellState();
}

class _EstimateItemsCellState extends State<EstimateItemsCell> {
  void _countring(int value,bool increase){
    if(increase){
      value = (value+widget.wSellerArray.itmNoOfPack);
      setState(() {
        widget.wSellerArray.qty = value;
      });
    }else{
      if(value > 1){

        if(value == widget.wSellerArray.itmNoOfPack){
          warningDialog(context, "Do you want to delete this item",widget.onTap);
        }else{
          value = (value-widget.wSellerArray.itmNoOfPack);
        }
        setState(() {
          widget.wSellerArray.qty = value;
        });
      }
    }
    widget.counting();

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (widget.wSellerArray.itmImageName != '')?SizedBox(width: 90,height: 120)/*Image.network(widget.wSellerArray.itmImageName,width: 90,height: 120,fit: BoxFit.fill,)*/
          :SizedBox(width: 90,height: 120),
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
                        Text(widget.wSellerArray.itmName,style: list_titleblack,overflow: TextOverflow.visible,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("₹"+widget.wSellerArray.itmPrice.toString(),style: TextStyle(color: appSecondColor,fontWeight: FontWeight.w500)),
                            Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Row(
                                children: [
                                  IconButton(onPressed: ()=> _countring(widget.wSellerArray.qty, false),icon: Icon(Icons.indeterminate_check_box_outlined,color: appSecondColor,size: 25)),
                                  SizedBox(width: 10),
                                  Text(widget.wSellerArray.qty.toString(),style: TextStyle(color: appSecondColor,fontWeight: FontWeight.w900)),
                                  SizedBox(width: 10),
                                  IconButton(onPressed: ()=> _countring(widget.wSellerArray.qty, true),icon: Icon(Icons.add_box_outlined,color: appSecondColor,size: 25)),

                                ],
                              ),
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
                          onTap: widget.onTap,
                          child: appIcon(iconData : Icons.delete)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],),
      ),
    );
  }
}
