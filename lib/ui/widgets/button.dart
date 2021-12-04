 import 'package:flutter/material.dart';
 import 'package:bwc/constant/constants.dart';

class RisedButtonuv extends StatelessWidget {
  String title;
  GestureTapCallback onTap;
  bool loading;
  Color color;
  double textSize;
  bool margin;
  RisedButtonuv({this.title, this.onTap,this.loading = false,this.color = appSecondColor,
    this.textSize = 20,this.margin = true});

  @override
   Widget build(BuildContext context) {
     return  Container(
       margin: (margin)?EdgeInsets.all(10):EdgeInsets.symmetric(horizontal: 10,vertical: 3),
       child: SizedBox(
         child: RaisedButton(
           shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(5.0),
           ),
          splashColor: Colors.white.withOpacity(0.5),
           color: color,
           child: Container(margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
               child: (!loading)?Text(title,style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSize, color: Colors.white)):
               (textSize == 20)?CircularProgressIndicator(backgroundColor: color,
               valueColor: new AlwaysStoppedAnimation<Color>(appColor)):
               SizedBox(
                 child: CircularProgressIndicator(backgroundColor: color,
                     valueColor: new AlwaysStoppedAnimation<Color>(appColor)),
                 height: 10.0,
                 width: 10.0,
               )),
           onPressed: onTap,
         ),
       ),
     );
   }
 }
