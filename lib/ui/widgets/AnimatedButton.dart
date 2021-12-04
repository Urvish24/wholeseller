 import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AnimatedButton extends StatefulWidget {
  String title;
  double width;
  Function(Function startLoading, Function stopLoading, ButtonState btnState) onTap;

  AnimatedButton({@required this.title, @required this.onTap,this.width});

  @override
   _AnimatedButtonState createState() => _AnimatedButtonState();
 }

 class _AnimatedButtonState extends State<AnimatedButton> {
   @override
   Widget build(BuildContext context) {
     return ArgonButton(
       height: 50,
       roundLoadingShape: true,
       width: (widget.width != null)? widget.width :MediaQuery.of(context).size.width * 0.45,
       onTap: widget.onTap,
       child: Text(
         widget.title,
         style: TextStyle(
             color: Colors.white,
             fontSize: 18,
             fontWeight: FontWeight.w700),
       ),
       loader: Container(
         padding: EdgeInsets.all(10),
         child: SpinKitRotatingCircle(
           color: Colors.white,
           // size: loaderWidth ,
         ),
       ),
       borderRadius: 5.0,
       color: appSecondColor,
     );
   }
 }
