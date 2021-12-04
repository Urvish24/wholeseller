
import 'package:flutter/material.dart';


class Bottom_item extends StatelessWidget {
  Function tap;
  int _index;
  int _current_index;
  String router,name;
  Bottom_item(this.tap, this._index,this._current_index,this.router,this.name);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap:  tap,
        child: Container(child: Center(child:
        Column(
          children: <Widget>[
            Card(
              color: Colors.transparent,
              elevation: (_current_index == _index)?4:0,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Material(
                child: Container(
                  width: 36,
                  height: 36,
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(18), color:(_current_index == _index)? Theme.of(context).primaryColor.withOpacity(0.2):Color.fromRGBO(243, 243, 243, 1)),
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    router,
                    fit: BoxFit.fill,
                    color:(_current_index == _index)? Theme.of(context).primaryColor:Colors.black,
                  ),
                ),
              ),
            ),
            Text(name,style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: (_current_index == _index)?Theme.of(context).primaryColor:Colors.black),)
          ],
        )
        )),
      ),
    );
  }
}