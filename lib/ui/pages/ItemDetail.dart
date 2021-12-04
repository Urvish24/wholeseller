import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';


class ItemDetail extends StatefulWidget {
  var data;


  ItemDetail({this.data});

  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerId = TextEditingController();
  TextEditingController _controllerNop = TextEditingController();
  final _focusName = FocusNode();
  final _focusPrice = FocusNode();
  final _focusId = FocusNode();
  final _focusNop = FocusNode();


  @override
  void initState() {
    _controllerName.text = widget.data.itmName;
    _controllerPrice.text = widget.data.itmPrice.toString();
    _controllerId.text = widget.data.itmId.toString();
    _controllerNop.text = widget.data.itmNoOfPack.toString();
  }

  Future<void> redirectDesk(var btnstop) async {
    if (_controllerName.text.isEmpty) {
      btnstop();
      show("Enter name",context,red);
    } else if (_controllerPrice.text.isEmpty) {
      btnstop();
      show("Enter price",context,red);
    } else if (_controllerId.text.isEmpty) {
      btnstop();
      show("Enter id",context,red);
    } else if (_controllerNop.text.isEmpty) {
      btnstop();
      show("Enter number of pack",context,red);
    } else {
      var map = new Map<String, dynamic>();
      map["itm_name"] = _controllerName.text;
      map["itm_id"] = _controllerId.text;
      map["itm_image_type"] = 'type';
      map["itm_image_name"] = widget.data.itmImageType;
      map["itm_price"] = _controllerPrice.text;
      map["itm_no_of_pack"] = _controllerNop.text;
      //model.imageApiCall(map,context);

      ContactRepository _contactRepository = ContactRepository(ContactDataSource());
      Map<String, dynamic> _responseMap  = await _contactRepository.editItem(map, widget.data.sId)  as Map<String, dynamic>;
      if(_responseMap["status"] == true){
        Navigator.pop(context);
      }else{
        show(_responseMap["message"],context,green);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text("Edit Item",
          style: TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 20,
          height: 20,
          child: appIcon(iconData: Icons.arrow_back),
        ),
      ),
    );

    return Scaffold(
      appBar: _appBarr,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    child: Container(
                      height: 150,
                      width: 120,
                      child: (widget.data.itmImageName != "")
                          ? Image.network(widget.data.itmImageName)
                          : SizedBox(),
                    ),
                  ),
                ),
              ),
              Text("Name", style: list_title),
              EditText(
                  controller: _controllerName,
                  focus: _focusName,
                  nextfocus: _focusId),
              sizedBoxlightUv,
              Text("Item Id", style: list_title),
              EditText(
                  controller: _controllerId,
                  focus: _focusId,
                  nextfocus: _focusPrice,
                  keybord: TextInputType.number),
              sizedBoxlightUv,
              Text("Price", style: list_title),
              EditText(
                  controller: _controllerPrice,
                  focus: _focusPrice,
                  nextfocus: _focusNop,
                  keybord: TextInputType.number),
              sizedBoxlightUv,
              Text("No of pack", style: list_title),
              EditText(
                  controller: _controllerNop,
                  focus: _focusNop,
                  keybord: TextInputType.number),
              sizedBoxlightUv,
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.center,
                child: AnimatedButton(
                    title: "Submit",
                    onTap: (startLoading, stopLoading, btnState) async => {
                      if (btnState == ButtonState.Idle)
                        {startLoading(), redirectDesk(stopLoading)}
                      else
                        {stopLoading()}
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
