



import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/CustomerListModel.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerListProvider extends ChangeNotifier {
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  CustomerListModel customerListModel;
  bool isLoading = true;

  callCustomerListcall(context) async {
    customerListModel = await _contactRepository.fetchCustomerListData();
    print("loginnnn " + customerListModel.status.toString());

    if (customerListModel.status.toString() != 'true') {
      show(customerListModel.message,context,red);
    }

    isLoading = false;
    notifyListeners();
  }
}
