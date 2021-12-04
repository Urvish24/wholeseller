import 'dart:convert';
import 'dart:io';

import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/models/CustomerListModel.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:bwc/models/ModelCustomer.dart';
import 'package:bwc/models/ModelImageUpload.dart';
import 'package:bwc/models/ModelItemCreate.dart';
import 'package:bwc/models/ModelItemDelete.dart';
import 'package:bwc/models/ModelItemListServer.dart';
import 'package:bwc/models/ModelItemZoho.dart';
import 'package:bwc/res/strings.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';

class ContactDataSource {

  Future<LoginModel> postLogin(var body,var context) async {
    var response = await http.post(Uri.parse(AppStrings.loginUrl), body: body);
    print("object " + response.body.toString());
    var data = json.decode(response.body);
    if (response.statusCode == 200) {
      LoginModel _loginData = LoginModel.fromJson(data);
      return _loginData;
    } else {
      print("CODE " + response.body.toString());
      normalDialog(context,data["message"]);
    }
  }

  Future<CustomerListModel> postCustomerList() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var response = await http.post(Uri.parse(AppStrings.customerList), headers: map);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      CustomerListModel _customerList = CustomerListModel.fromJson(data);
      return _customerList;
    } else {
      var data = json.decode(response.body);
      print("response " + data.toString());
      CustomerListModel _customerList = CustomerListModel.fromJson(data);
      return _customerList;
    }
  }

  Future<ModelCustomer> postCustomer(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    var response =
        await http.post(Uri.parse(AppStrings.customerCreate), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelCustomer _customerList = ModelCustomer.fromJson(data);
      return _customerList;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      // show(data['message'],context,Colors.red);
      ModelCustomer _customerList = ModelCustomer.fromJson(data);
      return _customerList;
    }
  }

  Future<ModelCustomer> updateCustomer(var data, String id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.customerUpdate + id);
    var response = await http.post(Uri.parse(AppStrings.customerUpdate + id),
        headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelCustomer _customerList = ModelCustomer.fromJson(data);
      return _customerList;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelCustomer _customerList = ModelCustomer.fromJson(data);
      return _customerList;
    }
  }

  Future<void> editItem(var data, String id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.itemUpdate + id);
    var response =
        await http.post(Uri.parse(AppStrings.itemUpdate + id), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }

  Future<ModelItemDelete> deleteItem(String id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    print("URL " + AppStrings.deleteItem + id);
    var response = await http.delete(Uri.parse(AppStrings.deleteItem + id), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemDelete _customerList = ModelItemDelete.fromJson(data);
      return _customerList;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }

  Future<ModelItemListServer> fetchServerItemList() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    var response = await http.post(Uri.parse(AppStrings.listServer), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemListServer _List = ModelItemListServer.fromJson(data);
      return _List;
    } else {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemListServer _List = ModelItemListServer.fromJson(data);
      return _List;
    }
  }

  Future<ModelItemZoho> fetchZohoItemList() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    var response = await http.post(Uri.parse(AppStrings.listZoho), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemZoho _List = ModelItemZoho.fromJson(data);
      return _List;
    } else {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemZoho _List = ModelItemZoho.fromJson(data);
      return _List;
    }
  }

  Future<ModelImageUpload> uploadImg(File file) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length(); //imageFile is your image file
    var uri = Uri.parse(AppStrings.uploadImage);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFileSign = new http.MultipartFile('updDocs', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFileSign);
    request.fields['updType'] = 'image';
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      /*if (response.statusCode == 200) {*/
      var data = json.decode(value);
      print("response " + data.toString());
      ModelImageUpload _List = ModelImageUpload.fromJson(data);
      return _List;
      /*} else {
        throw Exception();
      }*/
    });
  }

  Future<ModelItemCreate> createItem(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.createItem);
    var response =
        await http.post(Uri.parse(AppStrings.createItem), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemCreate _customerList = ModelItemCreate.fromJson(data);
      return _customerList;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      // show(data['message'],context,Colors.red);
      ModelItemCreate _customerList = ModelItemCreate.fromJson(data);
      return _customerList;
    }
  }

  Future<void> fetchSlabList() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    var response = await http.post(Uri.parse(AppStrings.slabList), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    }
  }


  Future<ModelItemZoho> fetchZohoItemListby() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    var response = await http.post(Uri.parse(AppStrings.slabList), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemZoho _List = ModelItemZoho.fromJson(data);
      return _List;
    } else {
      var data = json.decode(response.body);
      print("response " + data.toString());
      ModelItemZoho _List = ModelItemZoho.fromJson(data);
      return _List;
    }
  }

  Future<void> createSlab(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.slabCreate);
    var response =
        await http.post(Uri.parse(AppStrings.slabCreate), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }

  Future<void> editSlab(var data, String id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.slabUpdate + id);
    var response =
        await http.post(Uri.parse(AppStrings.slabUpdate + id), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> createEstimate(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.createEstimateForUser+" "+map.toString());
    print("data " + param.toString() );
    var response =
        await http.post(Uri.parse(AppStrings.createEstimateForUser), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> editEstimate(var data,var id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.editEstimateForUser+id+" "+map.toString());
    print("data " + param.toString() );
    var response =
        await http.put(Uri.parse(AppStrings.editEstimateForUser+id), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> estimateList(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.estimateListForUser+" "+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.estimateListForUser), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> estimateListByDate(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.estimateReports+" "+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.estimateReports), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
    }
  }
  Future<void> estimateUpdate(var data,id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.estimateUpdate+" "+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.estimateUpdate+id), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }

  Future<void> estimatedelete(var id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.estimateDeleteForUser+id+" "+map.toString());

    var response =
    await http.delete(Uri.parse(AppStrings.estimateDeleteForUser+id), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> estimateStatus(var data,id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.estimateUpdateStatus+id+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.estimateUpdateStatus+id), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }
  Future<void> getDashboard() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL "+ " $sells" + AppStrings.dashboard+" "+map.toString() );
    //toast// show(AppStrings.dashboard,context);
     String url  = "";
   /*  if(user){
       print("user");
     }else if(sells){
       print("sales");
     }else{
       print("admin");
     }*/
    var response =
    await http.get((sells)?Uri.parse(AppStrings.dashboardSales):Uri.parse(AppStrings.dashboard), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }

  Future<void> getInvoiceByCId(var id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.invoiceUrl+id+" "+map.toString());

    var response =
    await http.get(Uri.parse(AppStrings.invoiceUrl+id), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
     // // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> logout() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.signout+" "+map.toString());

    var response =
    await http.get(Uri.parse(AppStrings.signout), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
     // // show(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> getInvoiceById(var id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.invoiceByIdUrl+id+" "+map.toString());

    var response =
    await http.get(Uri.parse(AppStrings.invoiceByIdUrl+id), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
     // // show`(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> getEstimateById(var id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.estimateByIdUrl+id+" "+map.toString());

    var response =
    await http.get(Uri.parse(AppStrings.estimateByIdUrl+id), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
     // // show`(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> getStateList() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.stateListApi+" "+map.toString());

    var response =
    await http.get(Uri.parse(AppStrings.stateListApi), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
     // // show`(data['message'],context,Colors.red);
      throw Exception();
    }
  }

  Future<void> getlistEstimatesPendingCount() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.listEstimatesPendingCount+" "+map.toString());

    var response =
    await http.get(Uri.parse(AppStrings.listEstimatesPendingCount), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // // show`(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> fetchSallesList() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.sallesListApi+" "+map.toString());

    var response =
    await http.post(Uri.parse(AppStrings.sallesListApi), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
     // // show`(data['message'],context,Colors.red);
      throw Exception();
    }
  }
  Future<void> sellsCreating(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.saleCreate+param.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.saleCreate), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }
  Future<void> sellsEditing(var data,id) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.saleEdit+id+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.saleEdit+id), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;

      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }

  Future<void> forgotUser(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.forgotPassword+param.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.forgotPassword), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }

  Future<void> fetchingReportList(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.reports+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.reports), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;

      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }

  Future<void> postSettingsData(var data) async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    var param = json.encode(data);
    print("URL " + AppStrings.settings+map.toString());
    print("data " + param.toString() );
    var response =
    await http.post(Uri.parse(AppStrings.settings), headers: map, body: param);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;

      // show(data['message'],context,Colors.red);
      //throw Exception();
    }
  }
  Future<void> getSettingsData() async {
    var map = new Map<String, String>();
    map["Authorization"] = accessTocken;
    map["Content-Type"] = 'application/json';
    print("URL " + AppStrings.settings+map.toString());
    var response =
    await http.post(Uri.parse(AppStrings.settings), headers: map);
    print(response.body.toString());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print("response " + data.toString());
      return data;
    } else {
      print(response.statusCode.toString());
      print(response.body.toString());
      var data = json.decode(response.body);
      return data;
    }
  }
}
