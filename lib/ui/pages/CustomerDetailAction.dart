import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelCustomer.dart';
import 'package:bwc/provider/CustomerActionProvider.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:bwc/ui/widgets/stateCustomerCell.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


class CustomerDetailAction extends StatefulWidget {
  var data;

  @override
  _CustomerDetailActionState createState() => _CustomerDetailActionState();

  CustomerDetailAction(this.data);
}

class _CustomerDetailActionState extends State<CustomerDetailAction> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerBname = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerCID = TextEditingController();

  TextEditingController _controllerPswd = TextEditingController();
  TextEditingController _controllerCPswd = TextEditingController();
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  final _focusName = FocusNode();
  final _focusBname = FocusNode();
  final _focusPhone = FocusNode();
  final _focusCID = FocusNode();
  final _focusPswd = FocusNode();
  final _focusCPswd = FocusNode();
  var model;
  bool _isLoading = false;
  var _statList = [];
  var _id = "0";
  String _state = "";

  @override
  void initState() {
    model = Provider.of<CustomerActionProvider>(context, listen: false);
    _controllerName.text = widget.data.usrName;
    _controllerBname.text = widget.data.usrBusinessName;
    _controllerPhone.text = widget.data.usrPhoneNumber;
    _controllerCID.text = widget.data.usrCustomerId;

    _id = widget.data.stateDetail[0].sId;
    _state = widget.data.stateDetail[0].stName;
   // _controllerCity.text = widget.data.usrCity;
    // _controllerPswd.text =widget.data.usrPassword;
    /*setState(() {});*/
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

  void _showBottomSheetnew() {
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

  Future<void> _bottomValidation() async {
    if (_controllerPswd.text.isEmpty) {
      show("Enter new password",context,red);
    } else if (_controllerCPswd.text.isEmpty) {
      show("Enter confirm password",context,red);
    } else if (_controllerPswd.text.toString() !=
        _controllerCPswd.text.toString()) {
      show("Password and confirm password doesn't match",context,red);
    }  else if (_state.isEmpty) {
      show("Select your state",context,red);
    }else {
      var map = new Map<String, dynamic>();
      map["usr_name"] = _controllerName.text;
      map["usr_business_name"] = _controllerBname.text;
      map["usr_phone_number"] = _controllerPhone.text;
      map["usr_customer_id"] = _controllerCID.text;
      map["usr_password"] = _controllerPswd.text;
      map["usr_state_id"] = _id;
      ModelCustomer _customer =
          await _contactRepository.updateCustomerData(map, widget.data.sId);
      Navigator.pop(context);
      if (_customer.status == true) {
        model.chnageEdit();
        Navigator.of(context).pop();
        show(_customer.message,context,green);
      } else {
        show(_customer.message,context,red);
      }
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter updateState) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.white,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child:
                      /*GestureDetector(
                      onTap: () => {
                        updateState(() {
                          text = ""+index.toString();
                        })},
                    ),*/
                      Column(
                    children: [
                      Text(
                        "Change password",
                        style: TextStyle(
                            fontSize: 20,
                            color: appSecondColor,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 2,
                          color: blackiss),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBoxlightUv,
                            Text("Enter new password", style: list_title),
                            EditText(
                              controller: _controllerPswd,
                              focus: _focusPswd,
                              nextfocus: _focusCPswd,
                              obscureText: true,
                            ),
                            sizedBoxlightUv,
                            Text("Enter confirm password", style: list_title),
                            EditText(
                              controller: _controllerCPswd,
                              focus: _focusCPswd,
                              obscureText: true,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: RisedButtonuv(
                                title: "Submit",
                                onTap: () => {_bottomValidation()},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          });
        });
  }

  Future<void> apiCall(var btnstop) async {
    if (_controllerName.text.isEmpty) {
      btnstop();
      show("Enter name",context,red);
    } else if (_controllerBname.text.isEmpty) {
      btnstop();
      show("Enter business name",context,red);
    } else if (_controllerPhone.text.isEmpty) {
      btnstop();
      show("Enter phone number",context,red);
    } else if (_controllerPhone.text.length < 10) {
      btnstop();
      show("Mobile length must be at least 10 characters long",context,red);
    } else if (_controllerCID.text.isEmpty) {
      btnstop();
      show("Enter customerId",context,red);
    }else if (_state.isEmpty) {
      btnstop();
      show("Select your state",context,red);
    }else {
      setState(() {
        _isLoading = true;
      });
      var map = new Map<String, dynamic>();
      map["usr_name"] = _controllerName.text;
      map["usr_business_name"] = _controllerBname.text;
      map["usr_phone_number"] = _controllerPhone.text;
      map["usr_customer_id"] = _controllerCID.text;
      map["usr_state_id"] = _id;
      // map["usr_password"] = _controllerPswd.text;
      ModelCustomer _customer =
          await _contactRepository.updateCustomerData(map, widget.data.sId);
      if (_customer.status == true) {
        model.chnageEdit();
        Navigator.of(context).pop();
      } else {
        setState(() {
          _isLoading = false;
        });
        btnstop();
        show(_customer.message,context,red);
      }


    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text("Customer",
          style: TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 20,
          height: 20,
          child: appIcon(iconData: Icons.arrow_back),
        ),
      ),
      actions: [
        Consumer<CustomerActionProvider>(builder: (context, provider, _) {
          return (!model.edit)
              ? GestureDetector(
                  onTap: () => model.chnageEdit(),
                  child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: appIcon(iconData: Icons.edit)),
                )
              : SizedBox();
        })
      ],
    );
    return Consumer<CustomerActionProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: _appBarr,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: EdgeInsets.only(bottom: _appBarr.preferredSize.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Name", style: list_title),
                    EditText(
                      controller: _controllerName,
                      focus: _focusName,
                      nextfocus: _focusBname,
                      enable: provider.edit,
                    ),
                    sizedBoxlightUv,
                    Text("Business Name", style: list_title),
                    EditText(
                        controller: _controllerBname,
                        focus: _focusBname,
                        nextfocus: _focusPhone,
                        enable: provider.edit),
                    sizedBoxlightUv,
                    Text("Phone Number", style: list_title),
                    EditText(
                      controller: _controllerPhone,
                      focus: _focusPhone,
                      enable: provider.edit,
                    ),
                    sizedBoxlightUv,
                    Text("Customer id", style: list_title),
                    EditText(
                      controller: _controllerCID,
                      focus: _focusCID,
                      keybord: TextInputType.number,
                      enable: provider.edit
                    ),
                    Text("State", style: list_title),
                    GestureDetector(
                        onTap: ()=>_showBottomSheetnew(),
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

                              border: Border.all(color:(provider.edit)?Colors.black.withOpacity(0.5):
                              Colors.black.withOpacity(0.1),width: 1)
                          ),
                          height: 50,
                        )),
                    sizedBoxlightUv,
                    SizedBox(
                      height: 50,
                    ),
                    (provider.edit)
                        ? Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                AnimatedButton(
                                    title: "Submit",
                                    width: MediaQuery.of(context).size.width *
                                        0.60,
                                    onTap: (startLoading, stopLoading,
                                            btnState) async =>
                                        {
                                          if (btnState == ButtonState.Idle)
                                            {
                                              startLoading(),
                                              await Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                apiCall(stopLoading);
                                              })
                                            }
                                          else
                                            {}
                                        }),
                                SizedBox(
                                  height: 30,
                                ),
                                RisedButtonuv(
                                  title: "Change password",
                                  onTap: () => {_showBottomSheet()},
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
            _isLoading
                ? Container(
                    child: Loader(),
                  )
                : SizedBox()
          ],
        ),
      );
    });
  }

  void redirectDesk() {
    Navigator.of(context).pop();
  }
}
