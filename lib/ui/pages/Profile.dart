import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/SafeArea_custom.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _statList = [];
  var _id = "0";
  String _state = "";
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  @override
  void initState() {
    print("My data $loginResponse");
    _findState();
  }

  Future<void> _findState() async {
    print("object"+stateArray.toString());
    _state = "";
    Map<String, dynamic> _responseMap =
        await _contactRepository.getState() as Map<String, dynamic>;
    if (stateArray.length > 0) {
      for (int i = 0; i < _responseMap['data'].length; i++) {
        for (int j = 0; j < stateArray.length; j++) {
          print(_responseMap['data'][i]['_id'] + " = " + stateArray[j]);
          if (_responseMap['data'][i]['_id'] == stateArray[j]) {
            //_statList.add(_responseMap['data'][i]);
            if(_state.length == 0){
              _state = _responseMap['data'][i]['st_name'];
            }else{
              _state =_state+", "+ _responseMap['data'][i]['st_name'];
            }
          }
        }
      }
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: My_Drawer(),
      appBar: AppBar(
        title: Text("My profile",
            style:
                TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Container(
            width: 20,
            height: 20,
            child: appIcon(iconData: Icons.menu),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            row('Name', loginModel.data.usrName),
            row('Phone Number', loginModel.data.usrPhoneNumber),
            (loginModel.data.usrBusinessName != null)
                ? row('Business Name', loginModel.data.usrBusinessName)
                : SizedBox(),
            row('User Role', loginModel.data.usrRole),
            (loginModel.data.usrCity != null)
                ? row('City', loginModel.data.usrCity)
                : SizedBox(),
            (admin == false )
                ? row('State', _state)
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget row(title, value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                title,
                style: list_title,
              )),
              Expanded(
                  child: Text(
                value,
                style: list_titleblack,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
