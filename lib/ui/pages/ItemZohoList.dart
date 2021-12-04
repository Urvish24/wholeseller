import 'package:bwc/constant/constants.dart';
import 'package:bwc/provider/ItemZohoListProvider.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/itemZohoWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class ItemZohoList extends StatefulWidget {
  const ItemZohoList({Key key}) : super(key: key);

  @override
  _ItemZohoListState createState() => _ItemZohoListState();
}

class _ItemZohoListState extends State<ItemZohoList> {
  var model;


  @override
  void initState() {
    model = Provider.of<ItemZohoListProvider>(context, listen: false);
    model.initApiCall(context);
  }

  void _doneClick(){
     model.doneApiCall(context);
  }
  @override
  Widget build(BuildContext context) {
    AppBar _appBarr = AppBar(
      title: Text("Select Items",
          style: TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          width: 20,
          height: 20,
          child: appIcon(iconData: Icons.arrow_back),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: ()=>_doneClick(),
          child: Container(
            padding: EdgeInsets.only(right: 10),
            child: Align(
                alignment: Alignment.center,
                child: Text("Done",style: TextStyle(fontWeight: FontWeight.w500),)),
          ),
        ),
      ],
    );
    return Scaffold(
        appBar: _appBarr,
        body: Consumer<ItemZohoListProvider>(builder: (context, provider, _) {
          return provider.isLoading
              ? Loader()
              : AnimationLimiter(
                  child: ListView.builder(
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 500.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                  child: GestureDetector(
                                      onTap: () =>
                                          provider.changeModelValue(index),
                                      child: itemZohoWidgets(
                                          provider.modelItemZoho.data[index],provider,index)),
                                ),
                              ),
                            ),
                          ),
                      itemCount: provider.modelItemZoho.data.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true),
                );
        }));
  }


}
