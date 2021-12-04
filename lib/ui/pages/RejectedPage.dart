import 'package:bwc/ui/widgets/button.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RejectedPage extends StatefulWidget {
  String _id;

  @override
  _RejectedPageState createState() => _RejectedPageState();
}

class _RejectedPageState extends State<RejectedPage> {
  TextEditingController _controllerEmail = TextEditingController();
  final _focusEmail = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Estimate Rejection'),
        ),
        body: Column(
          children: [

        Padding(
        padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EditText(
              placeholder: 'Enter Reson',
              controller: _controllerEmail,
              focus: _focusEmail,
              keybord: TextInputType.text),

          Row(
            children: <Widget>[
              Expanded(child:
              RisedButtonuv(title: "Submit",onTap: ()=>Navigator.pop(context, true))),
              Expanded(child:
              RisedButtonuv(title: "Cancel",onTap: ()=>Navigator.pop(context, false))),
            ],),
        ],
      ),
    ),
          ],
        ));
  }
}
