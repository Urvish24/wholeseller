import 'package:flutter/material.dart';

class stateCustomerCell extends StatelessWidget {
  var data;
  stateCustomerCell(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(data['st_name'],style: TextStyle(fontWeight: FontWeight.w600),),
      ),
    );
  }
}
