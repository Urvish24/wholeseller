import 'dart:async';

import 'package:bwc/Animations/FadeAnimation.dart';
import 'package:bwc/Animations/SizeRoute.dart';
import 'package:bwc/common/Common.dart';
import 'package:bwc/datasource/StorageUtil.dart';
import 'package:bwc/ui/pages/Estimates.dart';
import 'package:bwc/ui/pages/SignIn.dart';
import 'package:bwc/ui/pages/dashboardAdmin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bwc/constant/constants.dart';
import 'package:page_transition/page_transition.dart';

class Splash_screen extends StatefulWidget {
  @override
  _Splash_screenState createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen>
    with TickerProviderStateMixin {
  @override
  Future<void> initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: appSecondColor,
        statusBarIconBrightness: Brightness.light));

    StorageUtil.getInstance().then((value) => {
          if (StorageUtil.getBoolen("isLogin"))
            {
              loginData(),
              print(
                  "Login ${StorageUtil.getBoolen("isLogin")} Role ${StorageUtil.getString("userRole")}"),
              if (StorageUtil.getString("userRole") == "CUSTOMER")
                {
                  Timer(
                      Duration(seconds: 3),
                      () =>
                          /*        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                      return Estimates(StorageUtil.getString("usr_customer_id"));
                    }))*/
                      Navigator.push(
                          context,SizeRoute(page: Dashboard())
                      ))
                        /*  Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: Estimates(StorageUtil.getString(
                                      "usr_customer_id")))))*/
                }
              else
                {
                  Timer(
                      Duration(seconds: 3),
                      () => Navigator.push(
                          context,SizeRoute(page: Dashboard())
                        ))
                }
            }
          else
            {
              Timer(
                  Duration(seconds: 3),
                  () =>
                      /*Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) {
                        return SignIn();
                      }))*/

                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade, child: SignIn())))
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appSecondColor,
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -50,
              left: 0,
              child: Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(one),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(0.7, Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(one),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(1.7, Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(one),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Positioned(
              top: -200,
              left: 0,
              child: FadeAnimation(2.7, Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(one),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Text(
                  "MYFITNESS",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ),
              ),
            )
            // Text(app_name,style: TextStyle(color: appSecondColor,fontSize: 30,fontWeight:FontWeight.w800),)
          ],
        ),
      ),
    );
  }
}
