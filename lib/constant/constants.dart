library constants;

import 'package:flutter/material.dart';
const String currency="\$";
const String app_name="My Fitness";
const String BaseUrl_image = "http://5.189.174.164/contactapp/webapi/uploads/";
const String imageBasecat="http://emobileapps.in/magento";
const int RECENTSEARCH = 100;
const int TOPSELLING = 101;
const int NEWEST = 102;
const int FEATURED = 103;
const int CATEGORY_NEWEST = 104;
const int CATEGORY_FEATURED = 105;

// # Colors
const Color bluesss = Color.fromRGBO(239, 243, 246, 1);
const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color graisss = Color.fromRGBO(237, 237, 237, 1);
const Color blackiss = Color.fromRGBO(0, 0, 0, 0.3);
const Color bblackiss = Color.fromRGBO(0, 0, 0, 0.6);
const Color light_green = Color.fromRGBO(144,238,144, 0.6);
const Color appColor = Color.fromRGBO(255, 255, 255, 1);
const Color appSecondColor = Color.fromRGBO(74, 144, 230, 1);
const Color red = Colors.red;
const Color green = Colors.green;
const Color appSecondColorOpecity = Color.fromRGBO(183, 201, 224, 1.0);
const Color appCanvascolor = Color.fromRGBO(244, 249, 250, 1.0);

// # Textstyles
const TextStyle uvText_17_w600 = TextStyle(fontSize: 17, fontWeight: FontWeight.w600,);
const TextStyle uvText_15_none = TextStyle(fontSize: 15);
const TextStyle uvText_15_w600 = TextStyle(fontSize: 15, fontWeight: FontWeight.w600,);
const TextStyle uvText_17_w700 = TextStyle(fontSize: 15, fontWeight: FontWeight.w700,);
const TextStyle uvText_17_w500 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500,);
TextStyle get button_style => TextStyle(fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white);
TextStyle get list_title => TextStyle(fontWeight: FontWeight.w500, fontSize: 17,color: appSecondColor);
TextStyle get list_titleblack => TextStyle(fontWeight: FontWeight.w500, fontSize: 15);
TextStyle get list_normal => TextStyle(fontWeight: FontWeight.w400, fontSize: 13);
SizedBox get sizedBoxUv => SizedBox(height: 10,);
SizedBox get sizedBoxlightUv => SizedBox(height: 5,);
const TextStyle buttonUnfield_style = TextStyle(fontWeight: FontWeight.w500, fontSize: 20);


// # Images route
const String share = 'assets/images/icons/icon-share.png';
const String logo = 'lib/res/images/logo.png';
const String gLogo = 'lib/res/images/google.png';
const String fbLogo = 'lib/res/images/facebook.png';
const String telePhone = 'lib/res/images/phone.png';
const String smartPhone = 'lib/res/images/smartphone.png';
const String email = 'lib/res/images/mail.png';
const String internet = 'lib/res/images/internet.png';
const String creditCard = 'lib/res/images/creditcard.png';
const String camera = 'lib/res/images/image.png';
const String men = 'lib/res/images/men.png';
const String noti = 'lib/res/images/noti.png';
const String social = 'lib/res/images/social.png';
const String ic_discount = 'lib/res/images/ic_discount.png';
const String ghost = 'lib/res/images/ghost.png';
const String one = 'lib/res/images/one.png';

const String ic_home = 'lib/res/images/ic_home.png';
const String ic_store = 'lib/res/images/ic_store.png';
const String ic_categories = 'lib/res/images/ic_categories.png';
const String ic_educators = 'lib/res/images/ic_educators.png';
const String ic_submit_deal = 'lib/res/images/ic_submit_deal.png';
const String ic_user = 'lib/res/images/ic_user.png';
const String ic_logout = 'lib/res/images/ic_logout.png';



// # Borders
const BoxDecoration uvContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(
        color: Colors.lightBlueAccent, width: 2.0),
  ),
);

