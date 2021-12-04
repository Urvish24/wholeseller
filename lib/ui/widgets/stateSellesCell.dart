import 'package:bwc/constant/constants.dart';
import 'package:flutter/material.dart';

class stateSellesCell extends StatelessWidget {
  var data;
  stateSellesCell(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 26, width: 26,
              decoration: BoxDecoration(
                border: Border.all(
                    color: (data['st_is_deleted'] == true) ? appSecondColor : Colors
                        .black, width: (data['st_is_deleted'] == true) ? 8 : 2),
                borderRadius: BorderRadius.all(
                    Radius.circular(
                        13.0) //                 <--- border radius here
                ),
              ),
              child: Center(child: SizedBox(height: 13, width: 13,)),
            ),
            SizedBox(width: 20,),
            Text(data['st_name'],style: TextStyle(fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
