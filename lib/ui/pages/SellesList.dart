import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/CreateSelles.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/SellerCell.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:focus_detector/focus_detector.dart';

class SellesList extends StatefulWidget {
  const SellesList({Key key}) : super(key: key);

  @override
  _SellesListState createState() => _SellesListState();
}

class _SellesListState extends State<SellesList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading =false;
  var _sallesData = [];
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  @override
  void initState() {
   initApi();
  }

  Future<void> initApi() async {
    Map<String, dynamic> _responseMap = await _contactRepository
        .getSellesList() as Map<String, dynamic>;


    setState(() {
      _sallesData = _responseMap['data'];
      isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        initApi();
      },
      child: Scaffold(
          key: _scaffoldKey,
          drawer: My_Drawer(),
          appBar: AppBar(
            title: Text("Sales List",
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
                      return CreateSelles();
                    })),
                child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: appIcon(iconData: Icons.add_box_outlined)),
              )
            ],
          ),
          body:
            isLoading
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
                              child: SellerCell(
                                  wSellerArray: _sallesData[index],
                                  i: index),
                            ),
                          ),
                        ),
                      ),
                  itemCount: _sallesData.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true),
            ),
          ),
    );
  }
}
