import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:bwc/provider/LoginProvider.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/ForgoPswd.dart';
import 'package:bwc/ui/pages/Registation.dart';
import 'package:bwc/ui/pages/dashboardAdmin.dart';
import 'package:bwc/ui/widgets/AnimatedButton.dart';
import 'package:bwc/ui/widgets/SafeArea_custom.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:bwc/ui/widgets/margin.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:bwc/ui/widgets/textfieldpassword.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPswd = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPswd = FocusNode();
  var model;
  var tokenstr = '';


  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    _firebaseMessaging
        .getToken()
        .then((token) => {tokenstr = token, print('Token ' + token)});
  }

  Future<void> redirectDesk(var btnstop) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_controllerEmail.text.isEmpty) {
      btnstop();
      show("Enter mobile number",context,red);
    } else if (_controllerPswd.text.isEmpty) {
      btnstop();
      show("Enter password",context,red);
    } else {
      var map = new Map<String, dynamic>();
      map["usr_phone_number"] = _controllerEmail.text;
      map["usr_password"] = _controllerPswd.text;
      map["usr_device_token"] = tokenstr;
      print("heehhe " + map.toString());
      check(context).then((intenet) {
        if (intenet != null && intenet) {
          // Internet Present Case
          model.callAuthorizationSignincall(map, context, btnstop);
          print("Internet");
        } else {
          btnstop();
          normalDialog(context, "No Internet");
          print("No Internet");
        }
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: appSecondColor,
        statusBarIconBrightness: Brightness.light));
    _register();
    model = Provider.of<LoginProvider>(context, listen: false);
  }

  AppBar appbar = AppBar(
    title: Text("Login"),
  );

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
                            nextfocus: _focusPswd),
                        EditTextpass(
                            placeholder: 'Password',
                            controller: _controllerPswd,
                            focus: _focusPswd,
                            obscureText: true),
                        sizedBoxUv,
                        GestureDetector(
                            onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return ForgoPswd();
                            })),
                            child: Align(alignment: Alignment.bottomRight,child: Text("Forgot password",style: TextStyle(fontWeight: FontWeight.w600),))),
                        sizedBoxUv,
                        AnimatedButton(
                            title: "Login",
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

  Widget buildLoginBtnUi() {
    return RisedButtonuv(
      title: 'LogIn',
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return Dashboard();
      })),
      loading: false,
    );
  }

  Widget buildRegistationBtnUi() {
    return Margin(
        top: 30,
        child: RisedButtonuv(
            title: 'Registation',
            onTap: () =>
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return Registation();
                })),
            loading: false));
  }

  Widget Rounded(Widget _child) {
    return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: graisss,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Center(child: _child));
  }
}
