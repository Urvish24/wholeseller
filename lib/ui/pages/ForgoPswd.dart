import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/SafeArea_custom.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';

class ForgoPswd extends StatefulWidget {
  const ForgoPswd({Key key}) : super(key: key);

  @override
  _ForgoPswdState createState() => _ForgoPswdState();
}

class _ForgoPswdState extends State<ForgoPswd> {
  TextEditingController _controllerEmail = TextEditingController();
  final _focusEmail = FocusNode();
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  Future<void> redirectDesk(var btnstop) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_controllerEmail.text.isEmpty) {
      btnstop();
      show("Enter mobile number",context,red);
    } else {
      var map = new Map<String, dynamic>();
      map["usr_phone_number"] = _controllerEmail.text;
      check(context).then((intenet) async {
        if (intenet != null && intenet) {
          var map = new Map<String, dynamic>();
          map["usr_phone_number"] = _controllerEmail.text;
          Map<String, dynamic> _responseMap = await _contactRepository.forgotPswd(map)  as Map<String, dynamic>;;
          if (_responseMap["status"] == true) {
            show(_responseMap["message"],context,green);
            Navigator.of(context).pop();
          } else {
            show(_responseMap["message"],context,red);
          }
        } else {
          normalDialog(context, "No Internet");
          print("No Internet");
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea_custom(
      child: Scaffold(
        /*appBar: appbar,*/
        body: Container(
          color: appSecondColor,
          child: Center(
            child: Card(
              color: appCanvascolor,
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 8,
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image.network("https://homepages.cae.wisc.edu/~ece533/images/baboon.png"),
                        Container(
                          height: 50,
                          width: 230,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Hero(
                            tag: "logo",
                            child: Image.asset(
                              logo,
                              fit: BoxFit.fill,
                              color: appSecondColor,
                            ),
                          ),
                        ),
                        EditText(
                            placeholder: 'Mobile Number',
                            controller: _controllerEmail,
                            focus: _focusEmail,
                            keybord: TextInputType.phone,
                            ),
                        sizedBoxUv,
                        sizedBoxUv,
                        AnimatedButton(
                            title: "Submit",
                            onTap:
                                (startLoading, stopLoading, btnState) async => {
                              if (btnState == ButtonState.Idle)
                                {
                                  startLoading(),
                                  redirectDesk(stopLoading)
                                }
                              else
                                {
                                  // stopLoading()
                                }
                            }),
                        sizedBoxUv,
                        sizedBoxUv
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
