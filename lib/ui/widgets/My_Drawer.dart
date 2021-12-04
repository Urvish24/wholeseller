import 'dart:convert';
import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/StorageUtil.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/LoginModel.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/Customer.dart';
import 'package:bwc/ui/pages/Estimates.dart';
import 'package:bwc/ui/pages/EstimatesAdmin.dart';
import 'package:bwc/ui/pages/Items.dart';
import 'package:bwc/ui/pages/Profile.dart';
import 'package:bwc/ui/pages/ReportList.dart';
import 'package:bwc/ui/pages/SellesList.dart';
import 'package:bwc/ui/pages/Settings.dart';
import 'package:bwc/ui/pages/SignIn.dart';
import 'package:bwc/ui/pages/SlabList.dart';
import 'package:bwc/ui/pages/dashboardAdmin.dart';
import 'package:bwc/ui/pages/invoicePage.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/material.dart';

class My_Drawer extends StatefulWidget {



  @override
  _My_DrawerState createState() => _My_DrawerState();
}

class _My_DrawerState extends State<My_Drawer> {



  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: appColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: Card(
                          clipBehavior: Clip.hardEdge,
                          elevation: 4,
                          color: appSecondColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(logo),
                          )),
                    ),
                    SizedBox(height: 10,),
                    Text(loginModel.data.usrName,style: TextStyle(fontWeight: FontWeight.w700,color: appSecondColor,letterSpacing: 1,fontSize: 17),),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
              Container(
                height: 2,
                margin: EdgeInsets.only(top: 20),
                color: Color.fromRGBO(0, 0, 0, 0.3),
              ),
              sizedBoxUv,
              (sells)?
                  Column(
                children: [
                  ListTile(
                    leading: buildIcon(ic_home),
                    title: Text('Dashboard',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return Dashboard();
                      }));
                    },
                  ),
                  Container(
                    height: 50,
                    child: Stack(
                      children: [
                        ListTile(
                          leading: buildIcon(ic_store),
                          title: Text('Estimates',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                              return EstimatesAdmin(true);
                            }));
                          },
                        ),
                        Positioned(
                          right: 10,top: 10,bottom: 10,
                          child: Container(
                            height: 30,width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              color: appSecondColor,
                            ),
                            child: Center(child: Text(count.toString(),style: TextStyle(color: white,fontSize: 10,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: buildIcon(ic_user),
                    title: Text('Customer',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return Customer();
                      }));
                    },
                  )
                ],
              ):SizedBox(),
              (user)?
                  Column(
                children: [
                  ListTile(
                    leading: buildIcon(ic_home),
                    title: Text('Dashboard',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return Dashboard();
                      }));
                    },
                  ),
                  ListTile(
                    leading: buildIcon(ic_store),
                    title: Text('Estimates',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return Estimates(StorageUtil.getString("usr_customer_id"));
                      }));
                    },
                  ),
                  ListTile(
                    leading: buildIcon(ic_educators),
                    title: Text('Invoice',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {

                      StorageUtil.getInstance().then((value) => {
                        StorageUtil.clearpreferences()
                      });
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return invoicePage();
                      }));
                    },
                  ),
                ],
              ):SizedBox(),
              (admin)?
                  Column(
                    children: [
                      ListTile(
                        leading: buildIcon(ic_home),
                        title: Text('Dashboard',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return Dashboard();
                          }));
                        },
                      ),
                      ListTile(
                        leading: buildIcon(ic_store),
                        title: Text('Sales',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return SellesList();
                          }));
                        },
                      ),
                      ListTile(
                        leading: buildIcon(ic_educators),
                        title: Text('Report',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {

                          StorageUtil.getInstance().then((value) => {
                            StorageUtil.clearpreferences()
                          });
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return ReportList();
                          }));
                        },
                      ),
                      ListTile(
                        leading: buildIcon(ic_categories),
                        title: Text('Items',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return Items();
                          }));
                        },
                      ),
                      ListTile(
                        leading: buildIcon(ic_categories),
                        title: Text('Slabs',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return SlabList();
                          }));
                        },
                      ),
                      ListTile(
                        leading: buildIcon(ic_home),
                        title: Text('Settings for zoho',
                            style: TextStyle(fontWeight: FontWeight.w800)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                            return Settings();
                          }));
                        },
                      ),
                    ],
                  ):SizedBox(),
              /*ListTile(
                leading: buildIcon(ic_store),
                title: Text('Estimates',
                    style: TextStyle(fontWeight: FontWeight.w800)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return EstimatesAdmin();
                  }));
                },
              ),*/
              Column(
                children: [
                  ListTile(
                    leading: buildIcon(ic_user),
                    title: Text('My profile',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                        return Profile();
                      }));
                    },
                  ),
                  ListTile(
                    leading: buildIcon(ic_logout),
                    title: Text('Logout',
                        style: TextStyle(fontWeight: FontWeight.w800)),
                    onTap: () {
                      _logout(context);
                      StorageUtil.getInstance().then((value) => {
                        StorageUtil.clearpreferences()
                      });
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _logout(c) async {
    ContactRepository _contactRepository = ContactRepository(ContactDataSource());
    Map<String, dynamic> _responseMap = await _contactRepository
        .logoutt() as Map<String, dynamic>;
    if (_responseMap['status'] == true) {
      show(_responseMap['message'], c, red);
      Navigator.pop(c);
      Navigator.of(c).pushReplacement(MaterialPageRoute(builder: (_) {
        return SignIn();
      }));
    } else {
      show(_responseMap['message'], c, red);
    }
  }

  Widget buildIcon(String routes) {
    return Image.asset(
      routes,
      fit: BoxFit.fill,
      color: appSecondColor,
      height: 25,
      width: 25,
    );
  }
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  int count = 0;

  @override
  void initState() {
    initiApi();
  }

  Future<void> initiApi() async {
    Map<String, dynamic> _responseMap =
        await _contactRepository.getCount() as Map<String, dynamic>;
    setState(() {
      count = _responseMap["data"]["count"];
    });

   // print("COUNT $_responseMap");
  }
}
