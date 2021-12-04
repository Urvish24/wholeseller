import 'package:bwc/constant/constants.dart';
import 'package:bwc/provider/ProviderItemCreate.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class ItemCreatePage extends StatefulWidget {
  const ItemCreatePage({Key key}) : super(key: key);

  @override
  _ItemCreatePageState createState() => _ItemCreatePageState();
}

class _ItemCreatePageState extends State<ItemCreatePage> {
  var model;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerId = TextEditingController();
  final _focusName = FocusNode();
  final _focusPrice = FocusNode();
  final _focusId = FocusNode();

  @override
  void initState() {
    model = Provider.of<ProviderItemCreate>(context, listen: false);
  }

  @override
  void dispose() {
    print("object");
    model.dis();
  }

  Future<void> redirectDesk(var btnstop) async {
    print("object " + model.file.toString());
    if (model.file == null) {
      btnstop();
      show("Select image",context,red);
    } else if (_controllerName.text.isEmpty) {
      btnstop();
      show("Enter name",context,red);
    } else if (_controllerPrice.text.isEmpty) {
      btnstop();
      show("Enter price",context,red);
    } else if (_controllerId.text.isEmpty) {
      btnstop();
      show("Enter id",context,red);
    } else {
      var map = new Map<String, dynamic>();
      map["itm_name"] = _controllerName.text;
      map["itm_id"] = _controllerId.text;
      map["itm_image_type"] = 'type';
      map["itm_price"] = _controllerPrice.text;
      model.imageApiCall(map,context);


    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text("Create Item",
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => model.chooseFile(context),
                  child: Card(
                    child: Container(
                      height: 150,
                      width: 120,
                      child: Consumer<ProviderItemCreate>(
                          builder: (context, provider, _) {
                        return (provider.file != null)
                            ? Image.file(provider.file)
                            : SizedBox();
                      }),
                    ),
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
    );
  }
}
