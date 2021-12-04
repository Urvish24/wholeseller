import 'dart:io';

import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/CustomerListModel.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:bwc/models/ModelCustomer.dart';
import 'package:bwc/models/ModelImageUpload.dart';
import 'package:bwc/models/ModelItemCreate.dart';
import 'package:bwc/models/ModelItemDelete.dart';
import 'package:bwc/models/ModelItemListServer.dart';
import 'package:bwc/models/ModelItemZoho.dart';

class ContactRepository {

  ContactDataSource _contactDataSource;

  ContactRepository(this._contactDataSource);



  Future<LoginModel> fetchLoginData(var body,var context) async {
   return await _contactDataSource.postLogin(body,context);
  }

  Future<CustomerListModel> fetchCustomerListData() async {
    return await _contactDataSource.postCustomerList();
  }

  Future<ModelCustomer> postCustomerData(var body) async {
    return await _contactDataSource.postCustomer(body);
  }

  Future<ModelCustomer> updateCustomerData(var body,String id) async {
    return await _contactDataSource.updateCustomer(body,id);
  }

  Future<ModelItemDelete> deleteItem(String id) async {
    return await _contactDataSource.deleteItem(id);
  }

  Future<ModelItemListServer> fetchServerItemList() async {
    return await _contactDataSource.fetchServerItemList();
  }

  Future<ModelImageUpload> uploadImageData(File file) async {
    return await _contactDataSource.uploadImg(file);
  }

  Future<ModelItemCreate> createItem(var body) async {
    return await _contactDataSource.createItem(body);
  }

  Future<void> editItem(var body,id) async {
    return await _contactDataSource.editItem(body,id);
  }

  Future<ModelItemZoho> itemByZOho() async {
    return await _contactDataSource.fetchZohoItemList();
  }
  //slab

  Future<void> fetchSlabList() async {
    return await _contactDataSource.fetchSlabList();
  }

  Future<void> fetchSlabCreate(data) async {
    return await _contactDataSource.createSlab(data);
  }
  Future<void> updateSlab(data, id) async {
    return await _contactDataSource.editSlab(data, id);
  }
  Future<void> CreateEstimateForUser(data) async {
    return await _contactDataSource.createEstimate(data);
  }
  Future<void> EditEstimateForUser(data,id) async {
    return await _contactDataSource.editEstimate(data,id);
  }

  Future<void> estimateListForUser(data) async {
    return await _contactDataSource.estimateList(data);
  }

  Future<void> estimateListForUserByDate(data) async {
    return await _contactDataSource.estimateListByDate(data);
  }

  Future<void> estimateItemDelete(id) async {
    return await _contactDataSource.estimatedelete(id);
  }

  Future<void> logoutt() async {
    return await _contactDataSource.logout();
  }

  Future<void> estimateUpdate(data,id) async {
    return await _contactDataSource.estimateUpdate(data,id);
  }


  Future<void> estimateStatusChange(data,id) async {
    return await _contactDataSource.estimateStatus(data,id);
  }

  Future<void> dashboard() async {
    return await _contactDataSource.getDashboard();
  }

  Future<void> invoiceByCId(id) async {
    return await _contactDataSource.getInvoiceByCId(id);
  }

  Future<void> invoiceById(id) async {
    return await _contactDataSource.getInvoiceById(id);
  }

  Future<void> estimateById(id) async {
    return await _contactDataSource.getEstimateById(id);
  }

  Future<void> getState() async {
    return await _contactDataSource.getStateList();
  }

  Future<void> getCount() async {
    return await _contactDataSource.getlistEstimatesPendingCount();
  }

  Future<void> getSellesList() async {
    return await _contactDataSource.fetchSallesList();
  }

  Future<void> createSelles(data) async {
    return await _contactDataSource.sellsCreating(data);
  }
  Future<void> editSelles(data,id) async {
    return await _contactDataSource.sellsEditing(data, id);
  }
  Future<void> forgotPswd(data) async {
    return await _contactDataSource.forgotUser(data);
  }
  Future<void> fetchReports(data) async {
    return await _contactDataSource.fetchingReportList(data);
  }

  Future<void> postSettings(data) async {
    return await _contactDataSource.postSettingsData(data);
  }

  Future<void> getSettings() async {
    return await _contactDataSource.getSettingsData();
  }
}