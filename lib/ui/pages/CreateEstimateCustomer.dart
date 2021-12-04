import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelItemListServer.dart';
import 'package:bwc/models/ModelItemZoho.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/SlabList.dart';
import 'package:bwc/ui/widgets/EstimateItemsCell.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:bwc/ui/widgets/itemZohoWidgetsSecond.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CreateEstimateCustomer extends StatefulWidget {
  bool isfromedit;
  String estId;

  CreateEstimateCustomer({this.isfromedit,this.estId});

  @override
  _CreateEstimateCustomerState createState() => _CreateEstimateCustomerState();
}

class _CreateEstimateCustomerState extends State<CreateEstimateCustomer> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _rs = 0;
  double _grandTotal = 0;
  double _discount = 0;
  double _discountinprice = 0;
  ModelItemListServer _itemListServer;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  var array = [];
  var map;
  bool _isLoading = true;
  String estimate_id = "";

  changeModelValue(int i, var updateState) {

      updateState(() {
        _itemListServer.data[i].selected = !_itemListServer.data[i].selected;
      });
  }

  changeactualValue(int i) {
    setState(() {
      _itemListServer.data[i].selected = !_itemListServer.data[i].selected;
    });
  }

  void _done() {
    Navigator.pop(context);
    setState(() {});
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter updateState) {
            return Container(
                height: MediaQuery.of(context).size.height - 100,
                margin: EdgeInsets.only(top: 60),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child:
                    /*GestureDetector(
                  onTap: () => {
                    updateState(() {
                      text = ""+index.toString();
                    })},
                ),*/
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      children: [
                        Text(
                          "Select Items",
                          style: TextStyle(
                              fontSize: 20,
                              color: appSecondColor,
                              fontWeight: FontWeight.w800),
                          textAlign: TextAlign.center,
                        ),
                        Positioned(
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _done(),
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w800),
                                textAlign: TextAlign.center,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 2,
                        color: blackiss),
                    AnimationLimiter(
                      child: Expanded(
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
                                        child: itemZohoWidgetsSecond(
                                            _itemListServer.data[index],
                                            index,
                                            updateState),
                                      ),
                                    ),
                                  ),
                                ),
                            itemCount: _itemListServer.data.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true),
                      ),
                    ),
                  ],
                ));
          });
        });
  }

  @override
  void initState() {
    initApiCall();
  }

  initApiCall() async {
    _itemListServer = await _contactRepository.fetchServerItemList();
    Map<String, dynamic> _responseMap =
        await _contactRepository.fetchSlabList() as Map<String, dynamic>;

   if(widget.isfromedit){
     print("CID $cId");
     Map<String, dynamic> _responseMapEstimate = await _contactRepository
         .estimateById(widget.estId) as Map<String, dynamic>;
     estimate_id = _responseMapEstimate["data"]['estimate_id'];
     print("estimate_id "+estimate_id);
     print("SSSS"+_responseMapEstimate["data"]['line_items'].toString());
     var _editDetailArray = _responseMapEstimate["data"]['line_items'];

     for(int i =0; i<_itemListServer.data.length; i++){
       for(int j =0; j<_editDetailArray.length; j++){
         print("myname  ${_itemListServer.data[i].itmName} == ${_editDetailArray[j]['name']}");

         if(_itemListServer.data[i].itmId == _editDetailArray[j]['item_id']){
           _itemListServer.data[i].selected = !_itemListServer.data[i].selected;
           _itemListServer.data[i].qty = _editDetailArray[j]['quantity'];
           _itemListServer.data[i].lineItemId = _editDetailArray[j]['line_item_id'];

         }
       }
     }
   //  _itemListServer.data = _responseMapEstimate['line_items'];

   }


    setState(() {
      array = _responseMap['data'];
      _isLoading = false;
    });


  }

  _counting() {
    _rs = 0;
    List<dynamic> arrayJson = [];
    print("COUNTRINGGGG");
    if ((_itemListServer) != null) {
      for (int i = 0; i < _itemListServer.data.length; i++) {
        if (_itemListServer.data[i].selected) {
          _rs = _rs +
              (int.parse(_itemListServer.data[i].itmPrice) *
                  _itemListServer.data[i].qty);
          if(widget.isfromedit){
            if(_itemListServer.data[i].lineItemId != ""){
              arrayJson.add({
                "item_id": "",
                "line_item_id": _itemListServer.data[i].lineItemId,
                "quantity": _itemListServer.data[i].qty
              });
            }else{
              arrayJson.add({
                "item_id": _itemListServer.data[i].itmId,
                "quantity": _itemListServer.data[i].qty
              });
            }
          }else{
            arrayJson.add({
              "item_id": _itemListServer.data[i].itmId,
              "quantity": _itemListServer.data[i].qty
            });
          }

        }
      }

      for (int i = 0; i < array.length; i++) {
        //if(array[i].)
        var long1 = double.parse(array[i]['slb_min']);
        var long2 = double.parse(array[i]['slb_max']);
        var discount = double.parse(array[i]['slb_percentage']);

        // print("ALlll $long1 $long2 $discount");

        if (long1 < _rs && long2 > _rs) {
          _discount = discount;
        }
      }
      if(widget.isfromedit){
        map = {"discount": "$_discount%","customer_id":cId, "line_items": arrayJson};
      }else{
        map = {"discount": "$_discount%", "line_items": arrayJson};
      }

      print("ARRRAYY " + map.toString());
      _discountinprice = (_rs*_discount)/100;
      _grandTotal = _rs - _discountinprice;
      setState(() {});
    }
  }

  _submit() async {
    setState(() {
      _isLoading = true;
    });
    if(widget.isfromedit){
      Map<String, dynamic> _responseMap =
      await _contactRepository.EditEstimateForUser(map,estimate_id)
      as Map<String, dynamic>;
      setState(() {
        _isLoading = false;
      });
      if (_responseMap["status"] == true) {
        Navigator.pop(context);
        show(_responseMap["message"],context,green);
      }else{
        show(_responseMap["message"],context,red);
      }
    }else{
      Map<String, dynamic> _responseMap =
      await _contactRepository.CreateEstimateForUser(map)
      as Map<String, dynamic>;
      setState(() {
        _isLoading = false;
      });
      if (_responseMap["status"] == true) {
        Navigator.pop(context);
        show(_responseMap["message"],context,green);
      }else{
        show(_responseMap["message"],context,red);
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    _counting();
    return FocusDetector(
      onFocusGained: () {},
      child: Scaffold(
        key: _scaffoldKey,
        drawer: My_Drawer(),
        appBar: AppBar(
          title: Text((widget.isfromedit)?"Edit Estimate":"Create Estimate",
              style: TextStyle(
                  color: appSecondColor, fontWeight: FontWeight.w800)),
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
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SlabList(direct: false);
                    })),
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Discount",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                )),
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 60,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    (_itemListServer) != null
                        ? AnimationLimiter(
                            child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 500.0,
                                        child: FadeInAnimation(
                                          child: (_itemListServer
                                                      .data[index].selected ==
                                                  true)
                                              ? Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                                  child: EstimateItemsCell(
                                                    wSellerArray:
                                                        _itemListServer
                                                            .data[index],
                                                    i: index,
                                                    onTap: () =>
                                                        changeactualValue(
                                                            index),
                                                    counting: _counting,
                                                  ))
                                              : SizedBox(),
                                        ),
                                      ),
                                    ),
                                itemCount: _itemListServer.data.length,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 170.0),
                      child: RisedButtonuv(
                        title: "+ Add item",
                        onTap: () => {_showBottomSheet()},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (_rs > 0)?Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: appSecondColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Sub Total',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ':',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹$_rs',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Discount ($_discount%)',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ':',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹$_discountinprice',
                                    textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          height: 0.5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Grand Total',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  ':',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '₹$_grandTotal',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 1,
                  ),
                  RaisedButton(
                      onPressed: () => _submit(),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      color: appSecondColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "SUBMIT",
                          style: button_style,
                        ),
                      ))
                ],
              ),
            ):SizedBox(),
            (_isLoading)
                ? Container(color: Colors.white, child: Loader())
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
