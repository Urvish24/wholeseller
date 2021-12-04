import 'package:bwc/constant/constants.dart';
import 'package:bwc/models/CustomerListModel.dart';
import 'package:bwc/provider/CustomerListProvider.dart';
import 'package:bwc/ui/pages/CustomerCreate.dart';
import 'package:bwc/ui/widgets/CustomerCell.dart';
import 'package:bwc/ui/widgets/EstimateCell.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:focus_detector/focus_detector.dart';

class Customer extends StatefulWidget {
  const Customer({Key key}) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _provider;

  @override
  void initState() {
    _provider = Provider.of<CustomerListProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        _provider.callCustomerListcall(context);
      },
      child: Scaffold(
          key: _scaffoldKey,
          drawer: My_Drawer(),
          appBar: AppBar(
            title: Text("Customer",
                style: TextStyle(
                    color: appSecondColor, fontWeight: FontWeight.w800)),
            leading: GestureDetector(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
              child: Container(
                width: 20,
                height: 20,
                child: appIcon(iconData: Icons.menu),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return CustomerCreate(create: true);
                })),
                child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: appIcon(iconData: Icons.add_box_outlined)),
              )
            ],
          ),
          body: Consumer<CustomerListProvider>(builder: (context, provider, _) {
            return provider.isLoading
                ? Loader()
                : AnimationLimiter(
                    child: ListView.builder(
                        itemBuilder: (context, index) =>
                            AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                horizontalOffset: 500.0,
                                child: FadeInAnimation(
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        CustomerCell(
                                            wSellerArray: provider
                                                .customerListModel.data[index],
                                            i: index),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        itemCount: provider.customerListModel.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true),
                  );
          })),
    );
  }
}
