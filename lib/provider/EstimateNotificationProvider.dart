

import 'package:flutter/material.dart';

class EstimateNotificationProvider extends ChangeNotifier{

  bool reload = false;

  reloadEstimate(isHappen){
    reload = isHappen;
    print("Provider data $isHappen");
    notifyListeners();
  }

}