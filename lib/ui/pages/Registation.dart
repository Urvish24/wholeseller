import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/dashboardAdmin.dart';
import 'package:bwc/ui/widgets/SafeArea_custom.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:bwc/ui/widgets/margin.dart';
import 'package:bwc/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';

class Registation extends StatefulWidget {
  const Registation({Key key}) : super(key: key);

  @override
  _RegistationState createState() => _RegistationState();
}

class _RegistationState extends State<Registation> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPswd = TextEditingController();
  TextEditingController _controllerCPswd = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  final _focusEmail = FocusNode();
  final _focusPswd = FocusNode();
  final _focusCPswd = FocusNode();
  final _focusName = FocusNode();

  @override
  Widget build(BuildContext context) {

    return SafeArea_custom(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registation"),
        ),
        body: Center(
          child: Margin(
            right: 10,
            left: 10,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(bottom: 40),
                    child: Hero(
                      tag: "logo",
                      child: Image.asset(
                        logo,
                        fit: BoxFit.fill,
                        color: appSecondColor,
                      ),
                    ),
                  ),
                  EditText(placeholder: 'Name', controller: _controllerName, focus: _focusName,
                      nextfocus: _focusEmail),
                  EditText(placeholder: 'Email', controller: _controllerEmail, focus: _focusEmail,
                      keybord: TextInputType.emailAddress,
                      nextfocus: _focusPswd),
                  EditText(placeholder: 'Password',controller: _controllerPswd,focus: _focusPswd,
                      obscureText: true,nextfocus: _focusCPswd),
                  EditText(placeholder: 'Confirm Password',controller: _controllerCPswd,focus: _focusCPswd,
                      obscureText: true),
                  sizedBoxUv,
                  buildRegistationBtnUi(),
                  sizedBoxUv,
                  Margin(top: 20,bottom: 20,child: Text("OR",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300))),
                  Margin(
                    left: 20,right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Rounded(Image.asset(fbLogo,height: 60,width: 60)),
                        Rounded(Image.asset(gLogo,height: 60,width: 60))
                      ],),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRegistationBtnUi(){
    return  Margin(
        top: 30,
        child: RisedButtonuv(title: 'Registation',onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return Dashboard();})),loading: false));
  }
  Widget Rounded(Widget _child){
    return Container(
        height: 80,width: 80,
        decoration: BoxDecoration(
          color: graisss,
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Center(child: _child)
    );
  }
}
