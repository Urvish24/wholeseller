import 'package:flutter/material.dart';

class SafeArea_custom extends StatelessWidget {
   Widget child;

   SafeArea_custom({@required this.child});

   @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
