import 'dart:ffi';

import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/CustomerDetailAction.dart';
import 'package:bwc/ui/pages/Estimates.dart';
import 'package:bwc/ui/pages/EstimatesAdmin.dart';
import 'package:bwc/ui/pages/invoicePage.dart';
import 'package:bwc/ui/widgets/WsellerCell.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/appIconcard.dart';
import 'package:bwc/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class CustomerCell extends StatelessWidget {
  var wSellerArray;
  int i;

  CustomerCell({this.wSellerArray,this.i});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return CustomerDetailAction(wSellerArray);
      })),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Padding(
          padding: const EdgeInsets.only(top:5.0,right: 5,left: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(wSellerArray.usrBusinessName,style: list_title,),
                         // Text(wSellerArray.usrCity,style: list_titleblack),
                        ],),
                        sizedBoxUv,
                        Container(height: 1,color: appSecondColor,),
                        sizedBoxUv,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(wSellerArray.usrName,style: list_titleblack,),
                            Text(wSellerArray.usrPhoneNumber,style: list_normal,),
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
              Row(
                children: [
                  Expanded(
                    child: RisedButtonuv(
                        title: 'Invoices',
                        textSize: 13,
                        onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return invoicePage(fromSeller: wSellerArray.usrCustomerId);
                          }))
                          /*usr_customer_id*/}),
                  ),
                  Expanded(
                    child: RisedButtonuv(
                        title: 'Estimates',
                        textSize: 13,
                        onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return EstimatesAdmin(false,cId:wSellerArray.usrCustomerId);
                          }))
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
