import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/StorageUtil.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/Estimates.dart';
import 'package:bwc/ui/pages/EstimatesAdmin.dart';
import 'package:bwc/ui/pages/SignIn.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/Toast.dart';

import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var grapgData = [];
  String text = "Drag Downwards Or Back To Dismiss Sheet";
  List<double> _graph = [];
  bool _isLoading = true;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  String totalEstimate="",totalEstimatePrice="",totalPending="",totalMonthly="";
  TooltipBehavior _tooltipBehavior;
  var sellsd = <SalesData>[];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: appColor,
        statusBarIconBrightness: Brightness.dark
    ));

    //toastShow("msg", context);
    loginData();
    initApiCall();
  }

  void initApiCall(){
    check(context).then((intenet) async {
      if (intenet != null && intenet) {

        // Internet Present Case
        Map<String, dynamic> _responseMap = await _contactRepository
            .dashboard()
        as Map<String, dynamic>;
        print("Internet");
        if(_responseMap["status"] == false){

          show(_responseMap["message"],context,red);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
            return SignIn();
          }));
        }
        totalEstimate = _responseMap['data']['totalEstimate'].toString();
        totalEstimatePrice = _responseMap['data']['totalEstimatePrice'].toString();
        totalPending = _responseMap['data']['totalPending'].toString();
        totalMonthly = _responseMap['data']['totalMonthly'].toString();

        grapgData = _responseMap['data']['graphData'];

        for(int i =0; i < grapgData.length ; i++){
          var date = grapgData[i]["date"];
          DateTime dateTime = new DateFormat("dd-MM-yyyy").parse(date);/*DateTime.parse(date);*/
          final DateFormat formatter = DateFormat('dd MMM');
          final String formatted = formatter.format(dateTime);
          sellsd.add(SalesData(/*grapgData[i]["date"]*/formatted, double.parse(grapgData[i]["total"])));
        }


        setState(() {
          _isLoading = false;
        });
      }else{
        normalDialog(context,"No Internet");
        print("No Internet");
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
      },
      child: Scaffold(
          key: _scaffoldKey,
          drawer: My_Drawer(),
          appBar: AppBar(
            title: Text("Dashboard",style: TextStyle(color: appSecondColor,fontWeight: FontWeight.w800)),
            leading: GestureDetector(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
              child: Container(
                width: 20,
                height: 20,
                child: appIcon(iconData : Icons.menu),
              ),
            ),
          ),
          body: (_isLoading)?Loader():Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _topTiles('Today Estimate',totalEstimate,'Today Pending',totalPending),
                  _tiles('Today value of estimates','₹ '+totalEstimatePrice,'Monthly estimates value','₹ '+totalMonthly),
                  SizedBox(height: 10),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.only(right:25.0,top:20.0),
                      child: SizedBox(
                        height: 320,
                        child: SfCartesianChart(
                            enableAxisAnimation: true,
                            primaryXAxis: CategoryAxis(
                              labelStyle: TextStyle(fontSize: 10,color: appSecondColor,fontWeight: FontWeight.w700),
                              maximumLabels: 100,
                              autoScrollingDelta: 4,
                              majorGridLines: MajorGridLines(width: 1),
                              majorTickLines: MajorTickLines(width: 1),
                            ),
                            primaryYAxis: NumericAxis(
                                numberFormat: NumberFormat('₹'),
                              labelStyle: TextStyle(fontSize: 10,color: appSecondColor,fontWeight: FontWeight.w700),),
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePanning: true,
                            ),
                            title: ChartTitle(text: 'Day estimate analysis'),
                            legend: Legend(isVisible: false),
                            tooltipBehavior: _tooltipBehavior,
                            series: <LineSeries<SalesData, String>>[
                              LineSeries<SalesData, String>(
                                color: appSecondColor,
                                  dataSource:sellsd,
                                  xValueMapper: (SalesData sales, _) => sales.year,
                                  yValueMapper: (SalesData sales, _) => sales.sales,
                                  // Enable data label
                                  dataLabelSettings: DataLabelSettings(isVisible: true),
                              )
                            ]
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _topTiles(var title1,var value1,var title2,var value2){
    return Row(children: [
      Expanded(
        child: GestureDetector(
          onTap: (){
            if(sells){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return EstimatesAdmin(true);
              }));
            }else if(user){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return Estimates(StorageUtil.getString("usr_customer_id"));
              }));
            }
          },
          child: Card(
            child: Container(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title1,style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                    SizedBox(height: 10,),
                    Text(value1,style: TextStyle(fontWeight: FontWeight.w700,color: appSecondColor),textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Card(
          child: Container(
            child:  AspectRatio(
              aspectRatio: 1 / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title2,style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                  SizedBox(height: 10,),
                  Text(value2,style: TextStyle(fontWeight: FontWeight.w700,color: appSecondColor),textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      )
    ],);
  }
  Widget _tiles(var title1,var value1,var title2,var value2){
    return Row(children: [
      Expanded(
        child: Card(
          child: Container(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title1,style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                  SizedBox(height: 10,),
                  Text(value1,style: TextStyle(fontWeight: FontWeight.w700,color: appSecondColor),textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Card(
          child: Container(
            child:  AspectRatio(
              aspectRatio: 1 / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title2,style: TextStyle(fontWeight: FontWeight.w400),textAlign: TextAlign.center),
                  SizedBox(height: 10,),
                  Text(value2,style: TextStyle(fontWeight: FontWeight.w700,color: appSecondColor),textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      )
    ],);
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
