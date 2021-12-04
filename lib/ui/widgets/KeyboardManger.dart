 import 'package:flutter/material.dart';

class KeyboardManger extends StatelessWidget {
  Widget child;

  KeyboardManger({this.child});

  @override
   Widget build(BuildContext context) {
     return GestureDetector(
         behavior: HitTestBehavior.opaque,
         onTap: () {
           FocusScope.of(context).requestFocus(new FocusNode());
         },
       child: child,
     );
   }
 }
