import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/CreateSlab.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/slabCell.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SlabList extends StatefulWidget {
  bool direct = true;

  SlabList({this.direct = true});

  @override
  _SlabListState createState() => _SlabListState();
}

class _SlabListState extends State<SlabList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  var array = [];



  Future<void> apiCalling() async {
    ContactRepository _contactRepository = ContactRepository(ContactDataSource());
    Map<String, dynamic> _responseMap  = await _contactRepository.fetchSlabList()  as Map<String, dynamic>;
    setState(() {
      array = _responseMap['data'];
      isLoading = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return FocusDetector(
        onFocusGained: () {
          apiCalling();
        },
        child: Scaffold(
            key: _scaffoldKey,
            drawer: My_Drawer(),
            appBar: AppBar(
              title: Text("Slabs",
                  style: TextStyle(
                      color: appSecondColor, fontWeight: FontWeight.w800)),
              leading: (widget.direct)?GestureDetector(
                onTap: () => _scaffoldKey.currentState.openDrawer(),
                child: Container(
                  width: 20,
                  height: 20,
                  child: appIcon(iconData: Icons.menu),
                ),
              ):
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 20,
                  height: 20,
                  child: appIcon(iconData: Icons.arrow_back),
                ),
              ),
              actions: [
                (widget.direct)? GestureDetector(
                  onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) {
                  return CreateSlab();
                })),
                  child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: appIcon(iconData: Icons.add_box_outlined)),
                ):SizedBox()
              ],
            ),
            body: isLoading
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
                              margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                              child: GestureDetector(
                                onTap: ()=> (widget.direct)?Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return CreateSlab(data: array[index],edit: true);
                                })):{},
                                child: slabCell(
                                    data: array[index],
                                    i: index,direct: widget.direct,),
                              ),
                            ),
                          ),
                        ),
                      ),
                  itemCount: array.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true),
            )
        ));
  }

}
