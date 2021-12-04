import 'package:toast/toast.dart';
import 'package:flutter/material.dart';



  void show(String msg,var context,Color color){
    Toast.show(msg,context, duration: Toast.LENGTH_SHORT,
        gravity:  Toast.BOTTOM,backgroundColor: color);

  }

void toastShow(String msg,var context,Color color){
   Toast.show("Toast plugin app",context, duration: Toast.LENGTH_SHORT,
       gravity:  Toast.BOTTOM,backgroundColor: color);

}
