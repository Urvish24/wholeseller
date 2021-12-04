import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/margin.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';

class itemZohoWidgetsSecond extends StatefulWidget {
  var data;
  int index;
  var updateState;

  itemZohoWidgetsSecond(this.data,this.index,this.updateState);

  @override
  _itemZohoWidgetsSecondState createState() => _itemZohoWidgetsSecondState();
}

class _itemZohoWidgetsSecondState extends State<itemZohoWidgetsSecond> {

  changeModelValue(int i,var updateState){
      updateState(() {
        widget.data.selected = !widget.data.selected;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: data.selected ? appSecondColorOpecity : Colors.white,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                  width: 60,
                  height: 90,
                  child: (widget.data.itmImageName != "")
                      ? /*Image.network(
                          widget.data.itmImageName,
                          fit: BoxFit.fill,
                        )*/
                        SizedBox()
                      : SizedBox()),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Margin(right: 30,child: Text(widget.data.itmName, style: list_titleblack)),
                      Text("₹" + widget.data.itmPrice.toString(),
                          style: TextStyle(
                              color: appSecondColor,
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("Pack of : ",
                              style: TextStyle(
                                  color: appSecondColor,
                                  fontWeight: FontWeight.w500)),

                      Text(widget.data.itmNoOfPack.toString(),
                          style: TextStyle(
                              color: appSecondColor,
                              fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              right: 0,
              child: Checkbox(value: widget.data.selected, onChanged: (bool value) { changeModelValue(widget.index,widget.updateState);},activeColor: appSecondColor,)),
        ],
      ),
    );
  }
}
