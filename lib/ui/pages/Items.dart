
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/provider/ItemsServerListProvider.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/ItemCreatePage.dart';
import 'package:bwc/ui/pages/ItemZohoList.dart';
import 'package:bwc/ui/widgets/ItemsCell.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:provider/provider.dart';

class Items extends StatefulWidget {
  const Items({Key key}) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ContactRepository contactRepository = ContactRepository(ContactDataSource());
  var _provider;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<ItemsServerListProvider>(context, listen: false);
    return FocusDetector(
      onFocusGained: () {
        _provider.fetchServerList(context);
      },
      child: Scaffold(
          key: _scaffoldKey,
          drawer: My_Drawer(),
          appBar: AppBar(
            title: Text("Items",
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
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) {
                  return ItemZohoList();
                })),
                child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: appIcon(iconData: Icons.add_box_outlined)),
              )
            ],
          ),
          body: Consumer<ItemsServerListProvider>(
              builder: (context, provider, _) {
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
                                    margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                    child: ItemsCell(
                                        wSellerArray: provider
                                            .modelitemListServer.data[index],
                                        i: index,model: _provider,),
                                  ),
                                ),
                              ),
                            ),
                        itemCount: provider.modelitemListServer.data.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true),
                  );
          })),
    );
  }
}
