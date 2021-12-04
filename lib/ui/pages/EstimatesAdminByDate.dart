import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/ClassicWebBrowserPage.dart';
import 'package:bwc/ui/pages/CreateEstimateCustomer.dart';
import 'package:bwc/ui/widgets/EstimateCell.dart';
import 'package:bwc/ui/widgets/EstimateCellAdmin.dart';
import 'package:bwc/ui/widgets/EstimateCellByDate.dart';
import 'package:bwc/ui/widgets/EstimateCellWithOutAccept.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/NoData.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/margin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EstimatesAdminByDate extends StatefulWidget {
  String sId;
  String date;



  EstimatesAdminByDate({this.sId,this.date});

  @override
  _EstimatesAdminByDateState createState() => _EstimatesAdminByDateState();
}

class _EstimatesAdminByDateState extends State<EstimatesAdminByDate> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _wSellerArray = [];
  bool _isLoading = true;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());


  @override
  void initState() {
    initiApi();
  }

  Future<void> initiApi() async {
    var map;
    if(widget.sId == "0"){
      map = {"date": "${widget.date}"};
    }else{
      map = {"date": "${widget.date}", "sales_id": widget.sId};
    }
    print("SIDDDD "+widget.sId);

      Map<String, dynamic> _responseMap = await _contactRepository
          .estimateListForUserByDate(map) as Map<String, dynamic>;

      setState(() {
        _wSellerArray = _responseMap['data'];
        _isLoading = false;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: My_Drawer(),
        appBar: AppBar(
          title: Text("Estimate by date",
              style: TextStyle(
                  color: appSecondColor, fontWeight: FontWeight.w800)),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 20,
              height: 20,
              child: appIcon(iconData: Icons.arrow_back),
            ),
          ),
        ),
        body: (_isLoading)
            ? Loader()
            : (_wSellerArray.length == 0)
            ? NoData(): Column(
          children: [
            Expanded(
                child: AnimationLimiter(
                  child: ListView.builder(
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              verticalOffset: 500.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: ()=>
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                              return ClassicWebBrowserPage(url:_wSellerArray[index]['est_url'],fromEstimate: true);
                                            })),
                                        child: EstimateCellByDate(
                                            wSellerArray:
                                            _wSellerArray[index],
                                            i: index,apiReload: initiApi),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      itemCount: _wSellerArray.length,
                      scrollDirection: Axis.vertical),
                ),
            )
          ],
        ));
  }
}
