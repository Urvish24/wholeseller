import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

import 'appIcon.dart';

class slabCell extends StatefulWidget {
  var data;
  int i;
  bool direct = true;


  slabCell({this.data, this.i,this.direct = true});

  @override
  _slabCellState createState() => _slabCellState();
}

class _slabCellState extends State<slabCell> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text("Minimum amount : ",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text("Minimum amount : ",
                  style: TextStyle(fontWeight: FontWeight.w600)),
              Text("Slab Percentage : ",
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ]),
            sizedBoxUv,
            Expanded(
              flex: 2,
              child: Column(children: [
                Text(widget.data['slb_min']),
                Text(widget.data['slb_max']),
                Text(widget.data['slb_percentage'] + '%',
                    style: TextStyle(fontWeight: FontWeight.w400))
              ]),
            ),
            sizedBoxUv,
            (widget.direct)?Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(color: appSecondColor,width: 1,height: 60,),
                  GestureDetector(
                     // onTap: ()=>model.deleteServerItem(wSellerArray.sId),
                      child: appIcon(iconData : Icons.edit_outlined)),
                ],
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
