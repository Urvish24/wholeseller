import 'package:bwc/common/Common.dart';
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


class CustomerCreate extends StatefulWidget {
  bool create;

  CustomerCreate({this.create = false});

  @override
  _CustomerCreateState createState() => _CustomerCreateState();
}

class _CustomerCreateState extends State<CustomerCreate> {
  ModelCustomer _customer;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerBname = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerCID = TextEditingController();
  final _focusName = FocusNode();
  final _focusBname = FocusNode();
  final _focusPhone = FocusNode();
  final _focusCID = FocusNode();
  bool _isLoading = true;
  var _statList = [];
  var _id = "0";
  String _state = "";

  @override
  void initState() {
    initApiCall();
  }

  Future<void> initApiCall() async {
    Map<String, dynamic> _responseMap =
        await _contactRepository.getState() as Map<String, dynamic>;

    for(int i =0;i<_responseMap['data'].length;i++){
      for(int j = 0;j<stateArray.length;j++){
        print(_responseMap['data'][i]['_id']+" = "+stateArray[j]);
        if(_responseMap['data'][i]['_id'] == stateArray[j]){
          _statList.add(_responseMap['data'][i]);

        }
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void Ontapstate(i){
    setState(() {
      _id = _statList[i]['_id'].toString();
      _state = _statList[i]['st_name'];
    });

    Navigator.of(context).pop();
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter updateState) {
                return Container(
                    margin: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/2,
                    color: Colors.white,
                    child:
                    /*GestureDetector(
                  onTap: () => {
                    updateState(() {
                      text = ""+index.toString();
                    })},
                ),*/
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Stack(
                          children: [
                            Text(
                              "Select State",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: appSecondColor,
                                  fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Container(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 2,
                            color: blackiss),
                        AnimationLimiter(
                          child: Expanded(
                            child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration: const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 500.0,
                                        child: FadeInAnimation(
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                            child: GestureDetector(
                                              onTap: ()=>Ontapstate(index),
                                              child: stateCustomerCell(
                                                  _statList[index]),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                itemCount: _statList.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true),
                          ),
                        ),
                      ],
                    ));
              });
        });
  }


  Future<void> apiCall(var btnstop) async {
    if (_controllerName.text.isEmpty) {
      btnstop();
      show("Enter name",context,red);
      //how("msg", context);
    } else if (_controllerBname.text.isEmpty) {
      btnstop();
      show("Enter business name",context,red);
    } else if (_controllerPhone.text.isEmpty) {
      btnstop();
      show("Enter phone number",context,red);
    } else if (_controllerPhone.text.length < 10) {
      btnstop();
      show("Mobile length must be at least 10 characters long",context,red);
    }else if (_controllerCID.text.isEmpty) {
      btnstop();
      show("Enter customerId",context,red);
    } else if (_state.isEmpty) {
      btnstop();
      show("Select your state",context,red);
    } else {

      var map = new Map<String, dynamic>();
      map["usr_name"] = _controllerName.text;
      map["usr_business_name"] = _controllerBname.text;
      map["usr_phone_number"] = _controllerPhone.text;
      map["usr_customer_id"] = _controllerCID.text;
      map["usr_state_id"] = _id;
      _customer = await _contactRepository.postCustomerData(map);
      if (_customer.status == true) {
        Navigator.of(context).pop();
      } else {
        show(_customer.message,context,red);
        btnstop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text(widget.create ? "Create Customer" : "Customer Detail",
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
      body: (_isLoading)?Loader():
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.only(bottom: _appBarr.preferredSize.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Name", style: list_title),
                EditText(
                    controller: _controllerName,
                    focus: _focusName,
                    nextfocus: _focusBname),
                sizedBoxlightUv,
                Text("Business Name", style: list_title),
                EditText(
                    controller: _controllerBname,
                    focus: _focusBname,
                    nextfocus: _focusPhone),
                sizedBoxlightUv,
                Text("Phone Number", style: list_title),
                EditText(
                    controller: _controllerPhone,
                    focus: _focusPhone,
                    keybord: TextInputType.phone,
                    nextfocus: _focusCID),
                sizedBoxlightUv,
                Text("Customer id", style: list_title),
                EditText(
                    controller: _controllerCID,
                    focus: _focusCID,
                    keybord: TextInputType.number),
                sizedBoxlightUv,
                Text("State", style: list_title),
                GestureDetector(
                    onTap: ()=>_showBottomSheet(),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.only(left: 10),
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              _state,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(5.0) //                 <--- border radius here
                          ),

                          border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
                      ),
                      height: 50,
                    )),
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
