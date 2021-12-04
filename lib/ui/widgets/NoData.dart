import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  const NoData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 140,width: 140,
                decoration: BoxDecoration(
                    color: appSecondColor,
                    borderRadius: BorderRadius.all(Radius.circular(70))
                ),
                child: SizedBox(width: 100,height: 100,child: Image.asset(ghost,width: 100,height: 100,))),
            SizedBox(height: 20,),
            Text("No Data",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
