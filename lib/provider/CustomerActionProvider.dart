

import 'package:flutter/material.dart';

class CustomerActionProvider extends ChangeNotifier{

  bool edit = false;

  chnageEdit(){
    edit = !edit;
    notifyListeners();
  }

}