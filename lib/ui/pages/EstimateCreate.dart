import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';


class EstimateCreate extends StatefulWidget {

  @override
  _EstimateCreateState createState() => _EstimateCreateState();
}

class _EstimateCreateState extends State<EstimateCreate> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerQuantity = TextEditingController();
  /*TextEditingController _controllerBname = TextEditingController();
  TextEditingController _controllerBname = TextEditingController();*/
  final _focusName = FocusNode();
  final _focusPrice = FocusNode();
  final _focusQuantity = FocusNode();
  var _chosenValue;
  /*final _focusBname = FocusNode();
  final _focusBname = FocusNode();*/

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr =  AppBar(
      title: Text("Create Estimate",style: TextStyle(color: appSecondColor,fontWeight: FontWeight.w800)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 20,
          height: 20,
          child: appIcon(iconData : Icons.arrow_back),
        ),
      ),
    );
    return Scaffold(
      appBar:_appBarr,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(bottom: _appBarr.preferredSize.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Name",style: list_title),
                EditText(
                    controller: _controllerName,
                    focus: _focusName,
                    nextfocus: _focusPrice),
                sizedBoxlightUv,
                Text("Price",style: list_title),
                EditText(
                    controller: _controllerPrice,
                    focus: _focusPrice,
                    nextfocus: _focusQuantity,
                    keybord: TextInputType.phone,),
                sizedBoxlightUv,
                Text("Quantity",style: list_title),
                EditText(
                    controller: _controllerQuantity,
                    focus: _focusQuantity,
                    keybord: TextInputType.number),
                sizedBoxlightUv,
                Text("Items",style: list_title),
                sizedBoxlightUv,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.8)),
                    borderRadius: BorderRadius.all(
                        Radius.circular(5.0)
                    ),
                  ),
                  child:DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      focusColor:Colors.white,
                      value: _chosenValue,
                      isExpanded: true,
                      elevation: 0,

                      style: TextStyle(color: Colors.white),
                      iconEnabledColor:appSecondColor,
                      items: <String>[
                        'Items1',
                        'Items2',
                        'Items3',
                        'Items4',
                        'Items5',
                        'Items6',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style:TextStyle(color:appSecondColor),),
                        );
                      }).toList(),
                      hint:Text(
                        "Please choose a items",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedButton(title: "Confirm",
                      onTap: (startLoading, stopLoading, btnState) async =>
                      {
                        if (btnState == ButtonState.Idle) {
                          startLoading(),
                          await Future.delayed(
                              const Duration(seconds: 2), () {
                            stopLoading();
                            redirectDesk();
                          })
                        } else
                          {
                            stopLoading()
                          }
                      }),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void redirectDesk() {
    Navigator.of(context).pop();
  }
}
