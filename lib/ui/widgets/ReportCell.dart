import 'dart:ffi';

import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/CustomerDetailAction.dart';
import 'package:bwc/ui/pages/EstimatesAdmin.dart';
import 'package:bwc/ui/pages/EstimatesAdminByDate.dart';
import 'package:bwc/ui/pages/SellerDetailAction.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class ReportCell extends StatelessWidget {
  var wSellerArray;
  int i;
  String sId;

  ReportCell({this.wSellerArray,this.i,this.sId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return EstimatesAdminByDate(sId:sId,date:wSellerArray['date']);
        }))
      },
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
                      Text("₹"+wSellerArray['est_total'],style: list_title,),
                      Text(wSellerArray['date'],style: list_titleblack),
                    ],),
                    sizedBoxUv,
                    Container(height: 1,color: appSecondColor,),
                    sizedBoxUv,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Estimate received : "+wSellerArray['est_received'].toString(),style: list_titleblack),
                        Text("Estimate pending : "+wSellerArray['pending'].toString(),style: list_normal,),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
