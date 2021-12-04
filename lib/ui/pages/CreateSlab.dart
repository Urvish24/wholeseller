import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class CreateSlab extends StatefulWidget {
  bool edit;
  var data;

  CreateSlab({this.edit = false, this.data});

  @override
  _CreateSlabState createState() => _CreateSlabState();
}

class _CreateSlabState extends State<CreateSlab> {
  TextEditingController _controllerSmin = TextEditingController();
  TextEditingController _controllerSmax = TextEditingController();
  TextEditingController _controllersParchantage = TextEditingController();

  final _focusSmin = FocusNode();
  final _focusSmax = FocusNode();
  final _focusParchantage = FocusNode();


  @override
  void initState() {
    if(widget.edit){
      _controllerSmin.text = widget.data['slb_min'];
      _controllerSmax.text = widget.data['slb_max'];
      _controllersParchantage.text = widget.data['slb_percentage'];
    }
  }

  Future<void> apiCall(var btnstop) async {
    if (_controllerSmin.text.isEmpty) {
      btnstop();
      show("Enter minimum slab",context,red);
    } else if (_controllerSmax.text.isEmpty) {
      btnstop();
      show("Enter Maximum slab",context,red);
    } else if (_controllersParchantage.text.isEmpty) {
      btnstop();
      show("Enter Slab Parchantage",context,red);
    } else if (double.parse(_controllerSmin.text) > double.parse(_controllerSmax.text)) {
      btnstop();
      show("Enter minimum amount greater than maximum amount",context,red);
    } else {
      var map = new Map<String, dynamic>();
      map["slb_min"] = _controllerSmin.text;
      map["slb_max"] = _controllerSmax.text;
      map["slb_percentage"] = _controllersParchantage.text;
      ContactRepository _contactRepository =
          ContactRepository(ContactDataSource());
      Map<String, dynamic> _responseMap =
          await _contactRepository.fetchSlabCreate(map) as Map<String, dynamic>;
      btnstop();

      if (_responseMap["status"] == true) {
        Navigator.of(context).pop();
      } else {
        show(_responseMap["message"],context,red);
      }
    }
  }

  Future<void> apiEditCall(var btnstop) async {
    if (_controllerSmin.text.isEmpty) {
      btnstop();
      show("Enter minimum amount",context,red);
    } else if (_controllerSmax.text.isEmpty) {
      btnstop();
      show("Enter maximum amount",context,red);
    } else if (_controllersParchantage.text.isEmpty) {
      btnstop();
      show("Enter Slab Parchantage",context,red);
    } else if (double.parse(_controllerSmin.text) > double.parse(_controllerSmax.text)) {
      btnstop();
      show("Enter minimum amount greater than maximum amount",context,red);
    }else {
      var map = new Map<String, dynamic>();
      map["slb_min"] = _controllerSmin.text;
      map["slb_max"] = _controllerSmax.text;
      map["slb_percentage"] = _controllersParchantage.text;
      ContactRepository _contactRepository =
          ContactRepository(ContactDataSource());
      Map<String, dynamic> _responseMap = await _contactRepository.updateSlab(
          map, widget.data["_id"]) as Map<String, dynamic>;
      btnstop();

      if (_responseMap["status"] == true) {
        Navigator.of(context).pop();
      } else {
        show(_responseMap["message"],context,red);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text(!widget.edit ? "Create Slab" : "Edit slab",
          style: TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 20,
          height: 20,
          child: appIcon(iconData: Icons.arrow_back),
        ),
      ),
    );
    return Scaffold(
      appBar: _appBarr,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(bottom: _appBarr.preferredSize.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20,),
                Text("Minimum amount", style: list_title),
                EditText(
                  controller: _controllerSmin,
                  focus: _focusSmin,
                  nextfocus: _focusSmax,
                  keybord: TextInputType.number,
                ),
                sizedBoxlightUv,
                Text("Maximum amount", style: list_title),
                EditText(
                  controller: _controllerSmax,
                  focus: _focusSmax,
                  nextfocus: _focusParchantage,
                  keybord: TextInputType.number,
                ),
                sizedBoxlightUv,
                Text("Slab percentage", style: list_title),
                EditText(
                  controller: _controllersParchantage,
                  focus: _focusParchantage,
                  keybord: TextInputType.number,
                ),
                sizedBoxlightUv,
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedButton(
                      title: "Submit",
                      onTap: (startLoading, stopLoading, btnState) async => {
                            if (btnState == ButtonState.Idle)
                              {
                                startLoading(),
                                !widget.edit
                                    ? apiCall(stopLoading)
                                    : apiEditCall(stopLoading)
                              }
                            else
                              {stopLoading()}
                          }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
