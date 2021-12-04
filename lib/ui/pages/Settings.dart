import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelCustomer.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/stateCustomerCell.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  ModelCustomer _customer;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  TextEditingController _controllerCode = TextEditingController();
  TextEditingController _controllerClientId = TextEditingController();
  TextEditingController _controllerClientSecret = TextEditingController();
  TextEditingController _controllerOrg = TextEditingController();
  final _focusCode = FocusNode();
  final _focusClientId = FocusNode();
  final _focusClientSecret = FocusNode();
  final _focusOrg= FocusNode();
  bool _isLoading = true;


  @override
  Future<void> initState() {
    _initApi();
  }
  Future<void> _initApi() async {
    Map<String, dynamic> _responseMap =
        await _contactRepository.getSettings() as Map<String, dynamic>;
    if (_responseMap["status"] == true) {
      _controllerCode.text = _responseMap['data']["code"].toString();
      _controllerClientId.text = _responseMap['data']["client_id"].toString();
      _controllerClientSecret.text = _responseMap['data']["client_secret"].toString();
      _controllerOrg.text = _responseMap['data']["organization_id"].toString();
    } else {
      show(_responseMap["message"], context, red);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> apiCall(var btnstop) async {
    if (_controllerCode.text.isEmpty) {
      btnstop();
      show("Enter code", context, red);
      //how("msg", context);
    } else if (_controllerClientId.text.isEmpty) {
      btnstop();
      show("Enter client id", context, red);
    } else if (_controllerClientSecret.text.isEmpty) {
      btnstop();
      show("Enter client secret", context, red);
    } else if (_controllerOrg.text.isEmpty) {
      btnstop();
      show("Enter organization id", context, red);
    } else {
      var map = new Map<String, dynamic>();
      map["code"] = _controllerCode.text;
      map["client_id"] = _controllerClientId.text;
      map["client_secret"] = _controllerClientSecret.text;
      map["organization_id"] = _controllerOrg.text;
      Map<String, dynamic> _responseMap =
          await _contactRepository.postSettings(map) as Map<String, dynamic>;
      if (_responseMap["status"] == true) {
        btnstop();
        show(_responseMap["message"], context, green);
        Navigator.of(context).pop();
      } else {
        show(_responseMap["message"], context, red);
        btnstop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text("Settings",
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
      body: (_isLoading)?Loader():SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(bottom: _appBarr.preferredSize.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Code", style: list_title),
                EditText(
                    controller: _controllerCode,
                    focus: _focusCode,
                    nextfocus: _focusClientId),
                sizedBoxlightUv,
                Text("Client id", style: list_title),
                EditText(
                    controller: _controllerClientId,
                    focus: _focusClientId,
                    nextfocus: _focusClientSecret),
                sizedBoxlightUv,
                Text("Client secret", style: list_title),
                EditText(
                    controller: _controllerClientSecret,
                    focus: _focusClientSecret,
                    nextfocus: _focusOrg),
                sizedBoxlightUv,
                Text("Organization id", style: list_title),
                EditText(
                    controller: _controllerOrg,
                    focus: _focusOrg),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedButton(
                      title: "Submit",
                      onTap: (startLoading, stopLoading, btnState) async => {
                            if (btnState == ButtonState.Idle)
                              {startLoading(), apiCall(stopLoading)}
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
