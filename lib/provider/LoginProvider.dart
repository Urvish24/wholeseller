

import 'dart:convert';

import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/StorageUtil.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/Estimates.dart';
import 'package:bwc/ui/pages/dashboardAdmin.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{

  ContactRepository contactRepository = ContactRepository(ContactDataSource());
  LoginModel loginModel;


  callAuthorizationSignincall(var map,var context,Function stop) async {
    loginModel = await contactRepository.fetchLoginData(map,context);
    print("loginnnn "+loginModel.toString());
    if(loginModel != null){
    if(loginModel.status.toString() == 'true'){
      stop();
      StorageUtil.getInstance().then((value) =>{
        StorageUtil.putString('user',jsonEncode(loginModel.toJson())),
        StorageUtil.putBool('isLogin', true),
        StorageUtil.putString('userRole', loginModel.data.usrRole),
        if(loginModel.data.usrRole == 'CUSTOMER'){

          StorageUtil.putString('usr_customer_id', loginModel.data.usrCustomerId),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return Dashboard();
          }))
        }else{


          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return Dashboard();
          }))
        }

      });
    }else{
      stop();
      show(loginModel.message,context,red);
    }}else{
      stop();
    }
    //notifyListeners();
  }

}