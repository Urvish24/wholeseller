import 'package:flutter/material.dart';

class Margin extends StatelessWidget {

  double top;
  double bottom;
  double right;
  double left;
  Widget child;


  Margin({@required this.child ,this.top = 0.0, this.bottom = 0.0, this.right = 0.0, this.left = 0.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
     child: child,
    );
  }
}
