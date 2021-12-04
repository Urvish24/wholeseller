import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:bwc/ui/widgets/margin.dart';

import 'Toast.dart';

class itemZohoWidgets extends StatefulWidget {
  var data;
  var provider;
  int index;

  itemZohoWidgets(this.data,this.provider,this.index);

  @override
  _itemZohoWidgetsState createState() => _itemZohoWidgetsState();
}

class _itemZohoWidgetsState extends State<itemZohoWidgets> {
  TextEditingController _controllerPack = TextEditingController();


  changeModelValue(int i){
    print("PACKKK "+widget.data.pack.toString());
    if(widget.data.pack != 0){
      setState(() {
        widget.data.selected = !widget.data.selected;
      });
    }else{
      show("Please add pack first",context,red);
    }

  }


  @override
  void initState() {
    if(widget.data.pack != 0){
      _controllerPack.text = widget.data.pack.toString();
    }
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
                  child: (widget.data.imageName != "")
                      ?/* Image.network(
                    widget.data.imageName,
                    fit: BoxFit.fill,
                  )*/SizedBox()
                      : SizedBox()),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Margin(right: 30,child: Text(widget.data.itemName, style: list_titleblack)),
                      Text("MRP " + widget.data.rate.toString(),
                          style: TextStyle(
                              color: appSecondColor,
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: [
                          Text("Pack Of : ",
                              style: TextStyle(
                                  color: appSecondColor,
                                  fontWeight: FontWeight.w500)),

                          SizedBox(
                            width: 60,
                            height: 30,
                            child:TextField(
                              onChanged: (content) {
                                if(_controllerPack.text.isNotEmpty){
                                  widget.data.pack = int.parse(_controllerPack.text);
                                 // widget.data.qty = int.parse(_controllerPack.text);
                                  print("state pack "+widget.data.pack.toString());
                                }
                              },
                              controller: _controllerPack,
                              keyboardType:  TextInputType.number,
                            ),
                          ),
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
              child: Checkbox(value: widget.data.selected, onChanged: (bool value) { changeModelValue(widget.index);},activeColor: appSecondColor,)),
        ],
      ),
    );
  }
}
