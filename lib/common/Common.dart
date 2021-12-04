
import 'dart:convert';

import 'package:bwc/datasource/StorageUtil.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sweetalert/sweetalert.dart';

String isSales;
var loginResponse;
LoginModel loginModel;
var accessTocken;
var cId;
var sId;
bool admin = false;
bool user = false;
bool sells = false;
var stateArray =[];


/*
* 'SALES'
*
* 'USER'
*
* 'ADMIN'*/
void loginData(){

    StorageUtil.getInstance().then((value) => {
      loginResponse = jsonDecode(StorageUtil.getString("user")),
      loginModel = LoginModel.fromJson(loginResponse),
      isSales = loginModel.data.usrRole,
      print("name ${loginModel.data.usrName}"),
      if(loginModel.data.usrRole == 'ADMIN'){
        admin = true,
        sells = false,
        user = false,
      }else if(loginModel.data.usrRole == 'SALES'){
        sells = true,
        admin = false,
        user = false,
        sId = loginModel.data.sId,
        stateArray = loginModel.data.usrStateId,
        print("SID "+sId.toString() + " "+stateArray.toString())
      }else{
        user = true,
        admin = false,
        sells = false,
        stateArray = loginModel.data.usrStateId,
      },
      accessTocken = loginModel.data.usrJwt,
      cId = loginModel.data.usrCustomerId,
      print("LOGIN " + accessTocken.toString()),
     // print("userid " + loginModel.data.usrJwt.toString())
    });

}

Future<bool> check(context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {

    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }

  return false;
}

void normalDialog(context,msg){
  SweetAlert.show(context, title: msg);
}

void warningDialog(context,msg,callback){
  SweetAlert.show(context,
      title: "Are you sure",
      subtitle: msg,
      style: SweetAlertStyle.confirm,
      showCancelButton: true, onPress: (bool isConfirm) {
        if (isConfirm) {
          callback();
          return true;
        }
      });
}